class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 15, scale: 2, null: false, default: 0.0
      t.string :brand, null: false
      t.jsonb :photo_urls, default: [], null: false

      t.timestamps
    end

    add_index :products, :brand
    add_index :products, :price
    add_index :products, :photo_urls, using: :gin
  end
end