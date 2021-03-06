# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout "pages"

  def create
    super do
      cable_ready[SessionChannel].dispatch_event(name: "reconnect").broadcast_to(request.session.id)
    end
  end
  def destroy
    # super do
    #   cable_ready[SessionChannel].dispatch_event(name: "reconnect").broadcast_to(request.session.id)
    # end
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    cable_ready[SessionChannel].dispatch_event(name: "reconnect").broadcast_to(request.session.id)
    redirect_to new_user_session_path
  end
end
