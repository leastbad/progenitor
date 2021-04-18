class ApplicationController < ActionController::Base
  include CableReady::Broadcaster
  include Pagy::Backend
  
  include QRCodeable
  include Toastable
  include Navigatable
  include Masqueradable

end
