class AddDeviseTwoFactorToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :encrypted_otp_secret, :string
    add_column :users, :encrypted_otp_secret_iv, :string
    add_column :users, :encrypted_otp_secret_salt, :string
    add_column :users, :consumed_timestep, :integer
    add_column :users, :otp_required_for_login, :boolean, default: false
    add_column :users, :otp_backup_codes, :string, array: true
    add_column :users, :otp_via_app, :boolean, default: false
    add_column :users, :otp_via_sms, :boolean, default: false
    add_column :users, :otp_sms_number, :string
  end
end
