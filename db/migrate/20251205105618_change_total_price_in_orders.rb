class ChangeTotalPriceInOrders < ActiveRecord::Migration[7.1]
  def up
    if column_exists?(:orders, :total_price)
      remove_column :orders, :total_price
    end

    add_column :orders, :total_price, :decimal, precision: 15, scale: 2, default: 0.0, null: false
    add_index  :orders, :total_price
  end

  def down
    remove_column :orders, :total_price
    add_column :orders, :total_price, :integer, default: 0, null: false
  end
end