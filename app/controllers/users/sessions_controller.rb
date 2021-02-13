# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def create
    super do
      ActionCable.server.remote_connections.where(session_id: session.id).disconnect
    end
  end
end