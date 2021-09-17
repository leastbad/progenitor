class Firehose
  include CableReady::Broadcaster

  attr_reader :redis

  def initialize
    @redis = ::ActionCable.server.pubsub.redis_connection_for_subscriptions
  end

  def process(command, key)
    case command # https://github.com/rails/kredis#examples
    when :set # string, integer, json
      cable_ready[:all_users].console_log(message: "#{key} was just updated to #{redis.get(key)}").broadcast
    when :rpush
      # list
    when :lrem
      # unique_list
    when :sadd
      # set
    when :incr
      # integer
    when :decr
      # integer
    when :incrby
      # integer
    when :decrby
      # integer
    when :exists
      # all
    when :del
      # all
    end
  end
end
