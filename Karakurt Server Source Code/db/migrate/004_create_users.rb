class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password
      t.string :password_hash
      t.boolean :admin, default: false, null: false
      t.boolean :is_active, default: false, null: false
      t.string :token, null: false

      t.timestamps
    end
  end
end