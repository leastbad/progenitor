class ApplicationController < ActionController::Base
  include CableReady::Broadcaster
  include Surge
  add_flash_types :primary, :secondary, :success, :danger, :warning, :info, :light, :dark
  before_action :qrcode, if: :user_signed_in?
  before_action :sidenav, if: :user_signed_in?
  after_action :broadcast_flash, if: :user_signed_in?
  after_action :clear_flash, unless: :user_signed_in?

  private

  def broadcast_flash
    flash.each { |k,v| FlashJob.set(wait: 2.second).perform_later(current_user, k, v) }
    flash.clear
  end

  def clear_flash
    flash.clear
  end

  def qrcode
    return @qr = false unless defined?(Ngrok::Tunnel) && Ngrok::Tunnel.running?
    @qr = Rails.cache.fetch("progenitor:qr:#{Ngrok::Tunnel.ngrok_url}") do
      RQRCode::QRCode.new(Ngrok::Tunnel.ngrok_url).as_svg(
        offset: 0, color: '000', shape_rendering: 'crispEdges', module_size: 6
      )
    end
  end

  def sidenav
    @sidenav = Surge::Sidenav.new(SIDENAV, request.path).to_s
  end
end
