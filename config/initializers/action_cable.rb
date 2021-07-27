# frozen_string_literal: true

# ActionCable.server.config.logger = Logger.new(nil)

module ActionCable
  module SubscriptionAdapter
    class SubscriberMap
      def initialize
        @subscribers = Hash.new { |h, k| h[k] = [] }
        @sync = Mutex.new
        @redis = ::ActionCable.server.pubsub.redis_connection_for_subscriptions
      end

      def add_subscriber(channel, subscriber, on_success)
        @sync.synchronize do
          new_channel = !@subscribers.key?(channel)

          @subscribers[channel] << subscriber

          if new_channel
            add_channel channel, on_success
          elsif on_success
            on_success.call
          end
        end
      end

      def remove_subscriber(channel, subscriber)
        @sync.synchronize do
          @subscribers[channel].delete(subscriber)

          if @subscribers[channel].empty?
            @subscribers.delete channel
            remove_channel channel
          end
          
          puts "Removed #{channel}"
        end
      end

      def channel_count_key(channel)
        [
          ActionCable.server.config.cable[:channel_prefix],
          channel,
          "count",
          Process.pid,
          Rails.object_id
        ].compact.join(":")
    end
  end
end
