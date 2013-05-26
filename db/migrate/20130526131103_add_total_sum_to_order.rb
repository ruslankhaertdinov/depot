class AddTotalSumToOrder < ActiveRecord::Migration
  def up
    add_column :orders, :total_sum, :decimal, precision: 8, scale: 2
  end

  def down
  end
end
