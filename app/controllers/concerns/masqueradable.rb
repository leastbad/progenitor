require "active_support/concern"

module Masqueradable
  extend ActiveSupport::Concern
  
  included do
    before_action :masquerade_user!, if: :user_signed_in?
  end
end