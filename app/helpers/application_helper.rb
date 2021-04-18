module ApplicationHelper
  include Pagy::Frontend
  
  def gravatar(email)
    hash = Digest::MD5.hexdigest(email)
    protocol = Rails.env.production? ? "https" : "http"
    "#{protocol}://secure.gravatar.com/avatar/#{hash}.png?s=24&d=retro"
  end

  def user_image(user)
    user.demo? ? asset_pack_path("media/images/team/#{user.name.downcase}.jpg") : gravatar(user.email)
  end
end
