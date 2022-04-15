class AddAuction < ActiveRecord::Migration[6.1]
  def change
    add_column :panel_configs, :auction_desc, :string, default: nil
  end
end