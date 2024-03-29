class TwoFactorAuthController < ApplicationController
  include Recognizable
  before_action :authenticate_user!
  before_action :real_users_only!

  def tfa
    @tfa_qr_code = current_user.otp_provisioning_uri(current_user.email, issuer: Rails.application.class.module_parent_name)

    # codes = current_user.generate_otp_backup_codes!
    # current_user.save!

    # current_user.validate_and_consume_otp!("")
  end
end
