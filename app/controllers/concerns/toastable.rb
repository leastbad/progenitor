# frozen_string_literal: true

module Toastable
  extend ActiveSupport::Concern
  
  included do
    add_flash_types :primary, :secondary, :success, :danger, :warning, :info, :light, :dark

    after_action :broadcast_flash, if: :user_signed_in?
    after_action :clear_flash, unless: :user_signed_in?

    private

    def broadcast_flash
      flash.each { |k, v| ToastJob.set(wait: 2.second).perform_later(current_user, k, v) }
      flash.clear
    end
  
    def clear_flash
      flash.clear
    end
  end
end