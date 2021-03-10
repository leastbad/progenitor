require "active_support/concern"

module Navigatable
  extend ActiveSupport::Concern
  include Surge
  
  included do
    before_action :build_navigation, if: :user_signed_in?

    private

    def build_navigation
      @sidenav = Surge::NavBuilder.new(SIDENAV, request.path).to_s
    end
  end
end