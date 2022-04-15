class AddToxId < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :tox_id, :string
  end
end