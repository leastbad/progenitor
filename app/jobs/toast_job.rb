class ToastJob < ApplicationJob
  queue_as :default

  def perform(user, type, message)
    ActionCable.server.broadcast("users:#{user.to_gid_param}", {notification: [type, message]})
  end
end
