class TwoFactorAuthReflex < ApplicationReflex
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

  def generate_codes
    morph "#otp_codes", current_user.generate_otp_backup_codes!.join("\n")
  end

  def disable
    current_user.update otp_required_for_login: false,
      otp_backup_codes: nil,
      otp_via_sms: false,
      otp_via_app: false,
      otp_sms_number: nil
  end
end