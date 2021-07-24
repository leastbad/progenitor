# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch("REDIS_URL") { "redis://localhost:6379/0" } }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch("REDIS_URL") { "redis://localhost:6379/0" } }
end

module Sidekiq
  class Subscriber
    include ::Sidekiq::Util

    def initialize
      @done = false
      @thread = nil
    end

    def start
      @thread ||= safe_thread("subscriber") {
        until @done
          Sidekiq.redis do |conn|
            # https://redis.io/topics/notifications#configuration
            conn.config(:set, "notify-keyspace-events", "E$lshz")
            # https://redis.io/topics/notifications#events-generated-by-different-commands
            conn.psubscribe("__key*__:*") do |on|
              on.psubscribe do
                @firehose = Firehose.new
              end
              on.pmessage do |pattern, command, key|
                @firehose.process(command.split(":").last.to_sym, key)
              end
              on.punsubscribe do
                @firehose = nil
              end
            end
          end
        end
        Sidekiq.logger.info("Subscriber exiting...")
      }
    end

    def terminate
      @done = true
      if @thread
        t = @thread
        Thread.kill(@thread)
        @thread = nil
        t.value
      end
    end
  end
end

module CoreExtensions
  module Sidekiq
    module Launcher
      attr_accessor :subscriber

      def initialize(options)
        @subscriber = ::Sidekiq::Subscriber.new
        super(options)
      end
  
      def run
        super
        subscriber.start
      end
  
      def quiet
        subscriber.terminate
        super
      end
  
      def stop
        subscriber.terminate
        super
      end
    end
  end
end

# Sidekiq.configure_server do
#   require "sidekiq/launcher"
#   ::Sidekiq::Launcher.prepend(CoreExtensions::Sidekiq::Launcher)
# end