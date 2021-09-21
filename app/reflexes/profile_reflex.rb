class ProfileReflex < ApplicationReflex
  include ActionView::Helpers::NumberHelper

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
    user = User.where(email: email, otp_required_for_login: true).first
    sms = user&.otp_via_sms?
    number = sms && user.otp_sms_number.tap { |p| p[1...-2] = "**-***-**" }
    self.payload = {
      tfa: user.present?,
      sms: sms,
      number: number
    }
    OtpSmsJob.perform_later(user) if sms
    morph :nothing
  end
end