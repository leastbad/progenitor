# frozen_string_literal: true

class ExampleEvent < ApplicationEvent
  repeats :forever
  every 3.seconds

  def perform(user, message)
    cable_ready[UsersChannel].console_log(message: message).broadcast_to(user)
  end
end
