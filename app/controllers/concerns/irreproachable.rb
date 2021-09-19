# frozen_string_literal: true

module Irreproachable
  extend ActiveSupport::Concern

  included do
    before_action :reject_masquerading_user!

    private
  
    def reject_masquerading_user!
      redirect_to root_path if user_signed_in? && user_masquerade?
    end
  end
end