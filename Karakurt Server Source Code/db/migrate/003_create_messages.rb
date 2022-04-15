class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :user_name
      t.string :user_surname
      t.string :title
      t.string :company
      t.string :email
      t.text :content

      t.timestamps
    end
  end
end
