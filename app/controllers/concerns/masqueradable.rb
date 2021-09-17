# frozen_string_literal: true

module Masqueradable
  extend ActiveSupport::Concern

  included do
    before_action :masquerade_user!, if: :user_signed_in?
  end
end
