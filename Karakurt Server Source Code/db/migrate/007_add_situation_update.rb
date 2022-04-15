class AddSituationUpdate < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :situation_update, :text
  end
end