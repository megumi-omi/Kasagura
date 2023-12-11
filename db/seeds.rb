categories = []
5.times do |n|
  name = Faker::Movies::BackToTheFuture.character
  categories << Category.create!(name: name)
end

frames = []
frame_alerts = []
5.times do |n|
  name = Faker::Travel::Airport.name(size: 'large', region: 'united_states')
  kind = Faker::Coin.flip
  inventory = Faker::Number.between(from: 1, to: 11)
  frame_alert = FrameAlert.create!(quantity: Faker::Number.between(from: 1, to: 11))
  frame = Frame.create!(name: name,
  kind: kind,
  inventory: inventory,
  frame_alert: frame_alert)
  frames << frame
  frame_alerts << frame_alert
end

product_quantities = []
3.times do |n|
  product_quantity = Faker::Number.between(from: 1, to: 11)
  product_quantities << ProductAlert.create!(quantity: product_quantity)
end

# 10.times do |n|
#   name = Faker::Tea.variety
#   image = Faker::Coffee.blend_name
#   stock = Faker::Number.between(from: 1, to: 11)
#   random_category = categories.sample
#   random_product_quantity = product_quantities.sample
#   random_frame = frames.sample
#   Product.create!(name: name,
#                   image: image,
#                   stock: stock,
#                   frame: random_frame,
#                   category: random_category,
#                   product_alert: random_product_quantity
#                   )
# end
