# frozen_string_literal: true

class ExampleReflex < ApplicationReflex
  def send_toast
    ToastJob.perform_later(current_user, "success", "Hi, #{current_user.name}!")
    morph :nothing
  end

  def send_message
    cable_ready[UsersChannel].console_log(message: "Hi, #{current_user.name}!").broadcast_to(current_user)
    morph :nothing
  end
end
