# frozen_string_literal: true

module Devisable
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
    end

    def real_users_only!
      if current_user.demo?
        flash[:info] = "That feature is not available to demo users."
        redirect_to root_path
      end
    end
  end
end
