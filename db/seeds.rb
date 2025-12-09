require "open-uri"

User.destroy_all
Product.destroy_all
Size.destroy_all
ProductSize.destroy_all

puts "Очищено базу даних"

puts "Створення розмірів..."
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
  },
  {
    name: "Nike Air Force 1 '07",
    brand: "Nike",
    price: 4899,
    description: "Легендарна класика, що не втрачає актуальності. Шкіряний верх та амортизація Nike Air.",
    photos: [
      "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/b7d9211c-26e7-431a-ac24-b0540fb3c00f/air-force-1-07-shoes-WrLlWX.png",
      "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/a0a300da-2e16-4483-ba64-9815cf0598ac/air-force-1-07-shoes-WrLlWX.png"
    ]
  },
  {
    name: "Adidas Samba OG",
    brand: "Adidas",
    price: 3999,
    description: "Ікона вуличного стилю. Замшеві накладки та ретро-підошва.",
    photos: [
      "https://www.mam-sport.de/webp/thumbnail/72/56/96/1748848743/adidas-samba-ih6000_1920x1920.webp",
      "https://www.mam-sport.de/webp/thumbnail/58/71/6b/1749200550/adidas-samba-ih6000_e26713137036d090_1920x1920.webp",

    ]
  },
  {
    name: "New Balance 530",
    brand: "New Balance",
    price: 4999,
    description: "Естетика ранніх 2000-х. Легка сітка та амортизація ABZORB.",
    photos: [
      "https://nb.scene7.com/is/image/NB/mr530sg_nb_02_i?$dw_detail_main_lg$&bgc=f1f1f1&layer=1&bgcolor=f1f1f1&blendMode=mult&scale=10&wid=1600&hei=1600",
      "https://nb.scene7.com/is/image/NB/mr530sg_nb_04_i?$dw_detail_main_lg$&bgc=f1f1f1&layer=1&bgcolor=f1f1f1&blendMode=mult&scale=10&wid=1600&hei=1600"
    ]
  },
  {
    name: "Reebok Club C 85",
    brand: "Reebok",
    price: 3299,
    description: "Мінімалістичний тенісний стиль. М'яка шкіра та логотип у віконці.",
    photos: [
      "https://www.reebok.eu/cdn/shop/files/22253012_53521420_800.webp?v=1744638910&width=800",
      "https://www.reebok.eu/cdn/shop/files/22253012_53520979_800.webp?v=1744638911&width=800",

    ]
  },
  {
    name: "Vans Old Skool",
    brand: "Vans",
    price: 2899,
    description: "Класичні скейт-кеди з фірмовою боковою смугою Sidestripe.",
    photos: [
      "https://www.outbacksylt.com/img/45940/vans-old-skool-36-lx-black-marshmallow-vn000e8vbpt1-1.jpg?options=rs:fill:1000:1000/g:ce/dpr:1",
      "https://www.outbacksylt.com/img/45953/vans-old-skool-36-lx-black-marshmallow-vn000e8vbpt1-2.jpg?options=rs:fill:1000:1000/g:ce/dpr:1",

    ]
  },
  {
    name: "Converse Chuck 70 High",
    brand: "Converse",
    price: 3499,
    description: "Преміальна версія класичних кедів з товстішою підошвою та міцним канвасом.",
    photos: [
      "https://cdn.skatedeluxe.com/thumb/1q5NZMwIjirIaf6OYwQgtXkLZ1Y=/fit-in/600x700/filters:fill(white):brightness(-4)/product/150751-0-Converse-CONSChuckHi70Canvas.jpg",
      "https://cdn.skatedeluxe.com/thumb/W9KOx5EGHybeK1DlpGz7fLnnen0=/fit-in/600x700/filters:fill(white):brightness(-4)/product/150751-1-Converse-ChuckHigh70Canvas.jpg?v=1",
      "https://cdn.skatedeluxe.com/thumb/6s04uw6Z7IZ7uE9u-Cyp4nlu2GE=/fit-in/600x700/filters:fill(white):brightness(-4)/product/150751-2-Converse-ChuckHigh70Canvas.jpg?v=1"
    ]
  },
  {
    name: "Nike Air Monarch IV",
    brand: "Nike",
    price: 2999,
    description: "Найпопулярніші 'dad shoes'. Максимальний комфорт та широка колодка.",
    photos: [
      "https://www.cortexpower.de/out/pictures/generated/product/1/1500_1500_75/nike-air-monarch-iv-whitemetallic-silver-415445-102.jpg",
      "https://www.cortexpower.de/out/pictures/generated/product/7/1500_1500_75/nike-air-monarch-iv-whitemetallic-silver-415445-102.jpg",
      "https://www.cortexpower.de/out/pictures/generated/product/14/1500_1500_75/nike-air-monarch-iv-whitemetallic-silver-415445-102.jpg"
    ]
  },
  {
    name: "Salomon XT-6",
    brand: "Salomon",
    price: 7899,
    description: "Трейлова ікона, що стала модною в місті. Система швидкої шнурівки та агресивний протектор.",
    photos: [
      "https://cdn.dam.salomon.com/c633336a-e6c5-4130-a5c2-b2f4016535ec/L47236600/PNG-2000px-max-72dpi.png?width=2000&fit=cover&optimize=low&bg-color=ffffff&format=pjpg",
      "https://cdn.dam.salomon.com/21bded08-b829-453f-8999-b2f40163768d/L47236600/PNG-2000px-max-72dpi.png?width=2000&fit=cover&optimize=low&bg-color=ffffff&format=pjpg",
      "https://cdn.dam.salomon.com/9f14de66-0b8e-448a-a736-b2f40163499b/L47236600/PNG-2000px-max-72dpi.png?width=2000&fit=cover&optimize=low&bg-color=ffffff&format=pjpg",

    ]
  },
  {
    name: "Adidas Superstar",
    brand: "Adidas",
    price: 3799,
    description: "Відомий 'gu shell toe' (черепашка). Класика баскетболу та хіп-хопу.",
    photos: [
      "https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/7ed0855435194229a525aad6009a0497_9366/Superstar_Shoes_White_EG4958_01_standard.jpg"
    ]
  },
  {
    name: "Hoka Clifton 9",
    brand: "Hoka",
    price: 6499,
    description: "Неймовірна легкість та амортизація для щоденних пробіжок.",
    photos: [
      "https://sportano.de/img/986c30c27a3d26a3ee16c136f92f4ff5/1/9/196565172419_20-jpg/hoka-herren-laufschuhe-clifton-9-schwarz-1127895-bwht-679381.jpg",
      "https://sportano.de/img/986c30c27a3d26a3ee16c136f92f4ff5/1/9/196565172419_24-jpg/hoka-herren-laufschuhe-clifton-9-schwarz-1127895-bwht-679385.jpg",
      "https://sportano.de/img/986c30c27a3d26a3ee16c136f92f4ff5/1/9/196565172419_29-jpg/hoka-herren-laufschuhe-clifton-9-schwarz-1127895-bwht-679390.jpg"
    ]
  }
]

puts "Створення товарів..."
products.each do |p|
  product = Product.create!(
    name:        p[:name],
    brand:       p[:brand],
    price:       p[:price],
    description: p[:description],
    photo_urls:  p[:photos]
  )
  Size.all.each do |size|
    product.sizes << size unless product.sizes.include?(size)
  end

  puts "Створено: #{product.name} (#{product.photo_urls.size} фото)"
end

User.find_or_create_by!(email: "admin@sportfoot.ua") do |u|
  u.password = "123456"
  u.password_confirmation = "123456"
  u.admin = true
end

puts ""
puts "УСПІШНО"
puts "Створено товарів: #{Product.count}"
puts "Створено розмірів: #{Size.count}"
puts "Адмін: admin@sportfoot.ua / 123456"