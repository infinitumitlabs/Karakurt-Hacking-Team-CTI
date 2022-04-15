class AddOsUserForFileWork < ActiveRecord::Migration[6.1]
  def change
    add_column :panel_configs, :os_file_user, :string, null: false, default: 'my_local_os_user'
  end
end