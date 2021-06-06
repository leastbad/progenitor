# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout "pages"

  def create
    super do
      cable_ready[SessionChannel].dispatch_event(name: "reconnect").broadcast_to(request.session.id)
    end
  end
  def destroy
    super do
      cable_ready[SessionChannel].dispatch_event(name: "reconnect").broadcast_to(request.session.id)
    end
  end
end
