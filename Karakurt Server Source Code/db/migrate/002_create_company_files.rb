class CreateCompanyFiles < ActiveRecord::Migration[6.1]

  def change
    create_table :company_files do |t|
      t.belongs_to :company
      t.string :uuid, null: false
      t.string :filename
      t.string :filepath
      t.float  :filesize
      t.string :mime_group
      t.string :mime_type
      t.boolean :published, default: false, null: false
      t.datetime :published_datetime

      t.timestamps
    end

    add_index :company_files, :uuid, unique: true
  end
end
