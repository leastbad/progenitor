class CreateUploadedFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :uploaded_files do |t|
      t.belongs_to :user
      t.timestamps
    end
  end
end
