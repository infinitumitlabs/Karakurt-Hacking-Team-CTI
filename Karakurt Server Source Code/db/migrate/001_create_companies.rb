class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.string :picture
      t.string :website
      t.string :address
      t.string :industry
      t.text   :description
      t.string :directory_code
      t.string :status, default: 'no active'
      t.string :state,  default: 'new'
      t.string :worker_archive_status, default: 'none'
      t.string :worker_publish_status, default: 'none'
      t.string :worker_log
      t.boolean :archive_ready,     default: false,   null: false
      t.integer :count_files,       default: 0

      t.integer  :shares_count,      default: 10,  null: false
      t.integer  :share_in_minutes,  default: 0,   null: false
      t.integer  :share_current,     default: 0,   null: false
      t.datetime :next_publication_date

      t.integer :data_size,           default: 0
      t.integer :data_size_published, default: 0
      t.date    :published_date
      t.integer :published_perc,      default: 0
      t.timestamps
    end

    add_index :companies, :uuid, unique: true
  end
end
