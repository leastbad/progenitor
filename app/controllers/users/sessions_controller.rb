# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout "pages"

  def create
    super do
      cable_ready[SessionChannel].dispatch_event(name: "reconnect").broadcast_to(request.session.id)
    end
  end

  def destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    cable_ready[SessionChannel].dispatch_event(name: "reconnect").broadcast_to(request.session.id)
    redirect_to unauthenticated_root_path
  end
end
