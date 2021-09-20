class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :recoverable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable, :rememberable, :validatable, :masqueradable, :two_factor_authenticatable, :two_factor_backupable, :otp_secret_encryption_key => Rails.application.credentials.devise_two_factor
  include Uploadable

  validates :email, 'valid_email_2/email': {mx: true, disposable: false, disallow_subaddressing: true}
  validates :email, uniqueness: true
end
