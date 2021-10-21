# frozen_string_literal: true

ActionCable.server.config.logger = Logger.new(nil)

# module ActionCable
#   module SubscriptionAdapter
#     class SubscriberMap
#       def initialize
#         @subscribers = Hash.new { |h, k| h[k] = [] }
#         @sync = Mutex.new
#         @redis = ::ActionCable.server.pubsub.redis_connection_for_subscriptions
#       end

#       def add_subscriber(channel, subscriber, on_success)
#         @sync.synchronize do
#           new_channel = !@subscribers.key?(channel)

#           @subscribers[channel] << subscriber

#           if new_channel
#             add_channel channel, on_success
#           elsif on_success
#             on_success.call
#           end
#           @redis.set channel_count_key(channel), @subscribers[channel].size, ex: 1.minute
#         end
#       end

#       def remove_subscriber(channel, subscriber)
#         @sync.synchronize do
#           @subscribers[channel].delete(subscriber)

#           if @subscribers[channel].empty?
#             @subscribers.delete channel
#             remove_channel channel
#           end

#           @redis.set channel_count_key(channel), @subscribers[channel].size, ex: 1.minute
#         end
#       end

#       def channel_count_key(channel)
#         [
#           ActionCable.server.config.cable[:channel_prefix],
#           channel,
#           "count",
#           Process.pid,
#           Rails.object_id
#         ].compact.join(":")
#       end

#       def channel_sum_key(channel)
#         [
#           ActionCable.server.config.cable[:channel_prefix],
#           channel,
#           "count",
#           "*"
#         ].compact.join(":")
#       end

#       def count_subscribers(channel)
#         puts @redis.get(channel_sum_key(channel))
#         # this 100% cannot work.
#         @redis.pubsub("channels", channel_sum_key(channel)).map {|key| @redis.get(key) }.sum
#       end
#     end
#   end
# end
