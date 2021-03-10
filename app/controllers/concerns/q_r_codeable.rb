require "active_support/concern"

module QRCodeable
  extend ActiveSupport::Concern
  included do
    
    before_action :qrcode, if: :user_signed_in?

    private

    def qrcode
      case Rails.env
      when "development"
        return @qr = false unless defined?(Ngrok::Tunnel) && Ngrok::Tunnel.running?
        @qr = generate_qr(Ngrok::Tunnel.ngrok_url)
      when "production"
        @qr = generate_qr(request.base_url)
      else
        @qr = false
      end
    end
  
    def generate_qr(url)
      Rails.cache.fetch("progenitor:qr:#{url}") do
        RQRCode::QRCode.new(url).as_svg(
          offset: 0, color: "000", shape_rendering: "crispEdges", module_size: 6
        )
      end.html_safe
    end
  end
end