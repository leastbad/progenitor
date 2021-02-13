# frozen_string_literal: true

class ExampleReflex < ApplicationReflex
  def send_message
    cable_ready[UsersChannel].console_log(message: "Hi!").broadcast_to(current_user)
    morph :nothing
  end
end
