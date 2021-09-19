class ProfileReflex < ApplicationReflex
  def toggle_2fa
    if element.checked && !current_user.otp_required_for_login?
      current_user.otp_required_for_login = true
      current_user.otp_secret = User.generate_otp_secret
      current_user.save!
    end
    if !element.checked && current_user.otp_required_for_login?
      current_user.otp_required_for_login = false
      current_user.otp_secret = nil
      current_user.save!
    end
  end
end