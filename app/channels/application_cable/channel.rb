module ApplicationCable
  class Channel < ActionCable::Channel::Base
    include CableReady::Broadcaster
    delegate :render, to: :ApplicationController

    # after_subscribe do
    #   Kredis.counter("#{channel_name}:count").increment
    # end

    # after_unsubscribe do
    #   Kredis.counter("#{channel_name}:count").decrement
    # end
  end
end
