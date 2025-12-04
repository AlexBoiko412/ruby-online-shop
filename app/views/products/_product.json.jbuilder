json.extract! product, :id, :name, :description, :price, :brand, :photo, :created_at, :updated_at
json.url product_url(product, format: :json)
json.photo url_for(product.photo)
