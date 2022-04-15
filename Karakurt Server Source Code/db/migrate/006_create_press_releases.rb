class CreatePressReleases < ActiveRecord::Migration[6.1]
  def change
    create_table :press_releases do |t|
      t.string :uuid, null: false
      t.string :title, null: false
      t.text :content
      t.string :picture
      t.boolean :published, default: false, null: false

      t.timestamps
    end
  end
end
