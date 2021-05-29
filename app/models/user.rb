class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :recoverable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable, :masqueradable
  include Uploadable

  validates :email, 'valid_email_2/email': {mx: true, disposable: false, disallow_subaddressing: true}
  validates :email, uniqueness: true
end
