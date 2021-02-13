module ApplicationHelper
  def gravatar(email)
    hash = Digest::MD5.hexdigest(email)
    protocol = Rails.env.production? ? "https" : "http"
    "#{protocol}://secure.gravatar.com/avatar/#{hash}.png?s=24&d=retro"
  end
end
