class ProfileController < ApplicationController
  include Irreproachable
  before_action :authenticate_user!

  def tfa
    if current_user.otp_required_for_login?
      @tfa_qr_code = current_user.otp_provisioning_uri(current_user.email, issuer: Rails.application.class.module_parent_name)
    end
  end
end