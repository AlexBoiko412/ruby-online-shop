class AddPhotoUrlsToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :photo_urls, :text
  end
end
