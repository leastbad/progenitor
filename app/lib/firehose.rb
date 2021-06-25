class Firehose
  include CableReady::Broadcaster

  attr_reader :redis

  def initialize
    @redis = Redis.new
  end

  def process(command, key)
    case command # https://github.com/rails/kredis#examples
    when :set    # string, integer, json
      cable_ready[:all_users].console_log(message: "#{key} was just updated to #{redis.get(key)}").broadcast
    when :rpush  # list
    when :lrem   # unique_list
    when :sadd   # set
    when :incr
    when :decr
    when :incrby
    when :decrby
    when :exists
    when :del
    else
    end
  end
end