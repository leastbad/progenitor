class ApplicationController < ActionController::Base
  include CableReady::Broadcaster
  add_flash_types :primary, :secondary, :success, :danger, :warning, :info, :light, :dark
  after_action :broadcast_flash, if: :user_signed_in?

  private

  def broadcast_flash
    flash.each { |k,v| FlashJob.set(wait: 2.second).perform_later(current_user, k, v) }
    flash.clear
  end
end
