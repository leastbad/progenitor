class ProfileReflex < ApplicationReflex
  def toggle_2fa
    current_user.tap do |u|
      if !u.demo? && !u.otp_required_for_login? && element.checked
        u.otp_required_for_login = true
        u.otp_secret = User.generate_otp_secret
        u.save!
      end
      if u.otp_required_for_login? && !element.checked
        u.otp_required_for_login = false
        u.otp_secret = nil
        u.save!
      end
    end
  end

  def otp_enabled(email)
    self.payload = true if User.where(email: email, otp_required_for_login: true).any?
    morph :nothing
  end
end