class OtpSmsJob < ApplicationJob
  queue_as :default

  def perform(user)
    account_sid = Rails.application.credentials.twilio_account_sid
    auth_token = Rails.application.credentials.twilio_auth_token
    Twilio::REST::Client.new(account_sid, auth_token).messages.create(
      body: "Your code is: #{user.current_otp}",
      from: Rails.application.credentials.twilio_number,
      to: user.otp_sms_number
    )
  end
end