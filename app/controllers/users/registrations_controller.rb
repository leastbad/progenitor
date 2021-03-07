# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include Optimism
  layout "pages"

  before_action :configure_permitted_parameters

  def create
    build_resource(sign_up_params)
    resource.save
    if resource.persisted?
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)
      # not needed when doing real page loads
      # cable_ready[SessionChannel].dispatch_event(name: "reconnect").broadcast_to(request.session.id)
      respond_with resource, location: root_path
    else
      clean_up_passwords resource
      set_minimum_password_length
      broadcast_errors resource, sign_up_params
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
