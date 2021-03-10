class ApplicationController < ActionController::Base
  include CableReady::Broadcaster
  
  include QRCodeable
  include Toastable
  include Navigatable
  include Masqueradable

end
