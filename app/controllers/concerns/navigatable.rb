# frozen_string_literal: true

module Navigatable
  extend ActiveSupport::Concern
  include Surge::Sidenav
  
  included do
    before_action :build_navigation, if: :user_signed_in?

    private

    def build_navigation
      @sidenav = Surge::NavBuilder.new(nodes, request.path).to_s
    end
  end
end