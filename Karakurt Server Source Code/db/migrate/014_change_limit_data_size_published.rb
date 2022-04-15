class ChangeLimitDataSizePublished < ActiveRecord::Migration[6.1]
  def change
    change_column :companies, :data_size_published, :bigint
  end
end
