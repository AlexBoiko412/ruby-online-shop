class RecreatePhotoUrlsAsJsonbInProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :photo_urls, :text

    add_column :products, :photo_urls, :jsonb, default: [], null: false
    add_index  :products, :photo_urls, using: :gin
  end
end