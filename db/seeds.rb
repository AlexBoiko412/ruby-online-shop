# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"

Product.destroy_all
Size.destroy_all

(38..46).each { |s| Size.create!(eu_size: s) }

products_data = [
  { name: "Nike Air Max 270",      brand: "Nike",    price: 5499,  img: "https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/6e0c6e1a-9b5d-4f0f-9e9e-8e5e8f8b8b8b/air-max-270-mens-shoes-KkLcSR.png" },
  { name: "Adidas Ultraboost 23",  brand: "Adidas",  price: 7299,  img: "https://assets.adidas.com/images/w_600,f_auto,q_auto/1f7b5c9e7a1d4e1b8c2aafd600e1c5e5_9366/Ultraboost_23_Shoes_Black_GY9353_01_standard.jpg" },
  { name: "Puma RS-X Toys",        brand: "Puma",    price: 4299,  img: "https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_2000,h_2000/global/369579/01/sv01/fnd/EEA/fmt/png" },
  { name: "New Balance 550",       brand: "New Balance", price: 5799, img: "https://nb.scene7.com/is/image/NB/bb550wt1_nb_02_i?$pdpflex2276$" },
  { name: "Asics Gel-Kayano 30",   brand: "Asics",   price: 6799,  img: "https://asics.scene7.com/is/image/asics/1011B548_400_SR_RT_GLB?$SFCC-zoom$" },
  { name: "Reebok Classic Leather",brand: "Reebok",  price: 3499,  img: "https://reebok.by/images/products/2023/11/100008491_1.jpg" },
  { name: "Nike React Element 55", brand: "Nike",    price: 4899,  img: "https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/u3d0m2f5q0d5r2b1n1j2/react-element-55-mens-shoes-6kL9k3.png" },
  { name: "Adidas NMD_R1",         brand: "Adidas",  price: 5999,  img: "https://assets.adidas.com/images/w_600,f_auto,q_auto/9d4b3e3b8f1f4e1b8c2aafd600e1c5e5_9366/NMD_R1_Shoes_Black_GZ9257_01_standard.jpg" },
]

products_data.each do |data|
  product = Product.create!(name: data[:name], brand: data[:brand], price: data[:price], description: "#{data[:brand]} #{data[:name]} — топова модель 2025 року!")

  downloaded_image = URI.open(data[:img])
  product.photo.attach(io: downloaded_image, filename: "#{data[:name].parameterize}.jpg", content_type: "image/jpeg")

  Size.all.each { |size| product.sizes << size }
end

User.create!(email: "admin@sportfoot.ua", password: "123456", password_confirmation: "123456") unless User.exists?

puts "Створено #{Product.count} товарів!"