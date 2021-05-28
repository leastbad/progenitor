# frozen_string_literal: true

module Toastable
  extend ActiveSupport::Concern
  
  included do
    add_flash_types :primary, :secondary, :success, :danger, :warning, :info, :light, :dark

    after_action :manage_flash

    private

    def manage_flash
      flash.each { |k, v| ToastJob.set(wait: 2.second).perform_later(current_user, k, v) } if user_signed_in?
      flash.clear
    end
  end
end