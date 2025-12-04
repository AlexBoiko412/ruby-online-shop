class AddEuSizeToSizes < ActiveRecord::Migration[7.1]
  def change
    add_column :sizes, :eu_size, :integer, null: false, default: 40
    add_index :sizes, :eu_size, unique: true
  end
end