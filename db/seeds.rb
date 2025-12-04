require "open-uri"

Product.destroy_all
Size.destroy_all
ProductSize.destroy_all
ActiveStorage::Attachment.destroy_all
ActiveStorage::Blob.destroy_all

(38..46).each { |n| Size.create!(eu_size: n) }
products = [
  {
    name: "Nike Air Max 270",
    brand: "Nike",
    price: 5499,
    description: "Легендарна модель з максимальною амортизацією Air.",
    photos: [
      "https://images1.sportpursuit.info/media/catalog/product/cache/1/image/800x800/040ec09b1e35df139433887a97daa66f/N/i/Nike_Oct25-BV2523-100_1.webp",
    ]
  },
  {
    name: "Adidas Ultraboost 23",
    brand: "Adidas",
    price: 7299,
    description: "Преміум-бігові кросівки з Boost-підошвою.",
    photos: [
      "https://intersport-de.imgdn.net/fsi/server?type=image&effects=Pad(cc,ffffff),Matte(FFFFFF)&width=1200&height=1200&source=marktplatz%2Fproduktiv%2F030%2FHQ6353%2FHQ6353_000_BILD01_20230729.jpg"
    ]
  },
  {
    name: "Puma RS-X Toys",
    brand: "Puma",
    price: 4299,
    description: "Яскравий ретро-дизайн з сучасними технологіями.",
    photos: [
      "https://img01.ztat.net/article/spp-media-p1/9d191ee41f70479c8bf8d5211a6011dd/7cddc8aebced4cc7a0d407f8d730c159.jpg?imwidth=1800&filter=packshot"
    ]
  },
  {
    name: "New Balance 550 White/Green",
    brand: "New Balance",
    price: 5799,
    description: "Культова модель 80-х у сучасному виконанні.",
    photos: [
      "https://nb.scene7.com/is/image/NB/bb550ptb_nb_02_i?$dw_detail_main_lg$&bgc=f1f1f1&layer=1&bgcolor=f1f1f1&blendMode=mult&scale=10&wid=1600&hei=1600",
      "https://nb.scene7.com/is/image/NB/bb550ptb_nb_04_i?$dw_detail_main_lg$&bgc=f1f1f1&layer=1&bgcolor=f1f1f1&blendMode=mult&scale=10&wid=1600&hei=1600",
      "https://nb.scene7.com/is/image/NB/bb550ptb_nb_07_i?$dw_detail_main_lg$&bgc=f1f1f1&layer=1&bgcolor=f1f1f1&blendMode=mult&scale=10&wid=1600&hei=1600"
    ]
  },
  {
    name: "Asics Gel-Kayano 30",
    brand: "Asics",
    price: 6799,
    description: "Максимальна стабільність і амортизація для бігу.",
    photos: [
      "https://sportano.de/img/986c30c27a3d26a3ee16c136f92f4ff5/1/9/197968081872_20-jpg/laufschuhe-damen-new-balance-fuelcell-venym-calcium-1484291.jpg"
    ]
  }
]

products.each do |p|
  product = Product.create!(
    name:        p[:name],
    brand:       p[:brand],
    price:       p[:price],
    description: p[:description],
    photo_urls:  p[:photos].join("|||")
  )
  Size.all.each { |s| product.sizes << s }
end

User.find_or_create_by!(email: "admin@sportfoot.ua") do |u|
  u.password = "123456"
  u.password_confirmation = "123456"
end

puts "Створено #{Product.count} товарів!"