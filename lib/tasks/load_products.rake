namespace :db do
  desc "Load 100 products into the database"
  task load_products: :environment do
    require 'faker'
    require 'open-uri'

    500.times do
      product = Product.create(
        name: Faker::Commerce.product_name,
        price: Faker::Commerce.price(range: 10..100.0),
        description: Faker::Lorem.paragraph(sentence_count: 5),
      )

      # Attach an image to the product from local assets
      image_path = Rails.root.join('app', 'assets', 'images', '250.jpg')
      file = File.open(image_path)
      product.image.attach(io: file, filename: "product#{product.id}.png")
    end

    puts "Loaded 100 products into the database."
  end
end