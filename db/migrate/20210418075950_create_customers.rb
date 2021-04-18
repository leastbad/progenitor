class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :company
      t.string :position
      t.string :state
      t.timestamps
    end
  end
end
