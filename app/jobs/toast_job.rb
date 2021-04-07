class ToastJob < ApplicationJob
  queue_as :default

  def perform(user, type, message)
    cable_ready[UsersChannel].toast(type: type, message: message).broadcast_to(user)
  end
end
