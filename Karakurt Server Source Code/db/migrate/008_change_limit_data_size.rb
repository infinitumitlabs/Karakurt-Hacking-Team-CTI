class ChangeLimitDataSize < ActiveRecord::Migration[6.1]
  def change
    change_column :companies, :data_size, :bigint
  end
end
