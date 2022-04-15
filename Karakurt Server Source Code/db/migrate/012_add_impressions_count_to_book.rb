class AddImpressionsCountToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :impressions_count, :integer, default: 0
    add_column :press_releases, :impressions_count, :integer, default: 0
  end
end