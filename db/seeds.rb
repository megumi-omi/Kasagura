category_1 = Category.create(name: "ポルカドット")
  image_path_1 = Rails.root.join('app/assets/images/category_polkadot.jpg')
  category_1.image.attach(io: File.open(image_path_1), filename: 'category_polkadot.jpg')

category_2 = Category.create(name: "ストライプ")
  image_path_2 = Rails.root.join('app/assets/images/category_stripe.jpg')
  category_2.image.attach(io: File.open(image_path_2), filename: 'category_stripe.jpg')

category_3 = Category.create(name: "フラワー")
  image_path_3 = Rails.root.join('app/assets/images/category_flower.jpg')
  category_3.image.attach(io: File.open(image_path_3), filename: 'category_flower.jpg')

category_4 = Category.create(name: "アニマルプリント")
  image_path_4 = Rails.root.join('app/assets/images/category_animal.jpg')
  category_4.image.attach(io: File.open(image_path_4), filename: 'category_animal.jpg')

category_5 = Category.create(name: "グラデーション")
  image_path_5 = Rails.root.join('app/assets/images/category_gradation.jpg')
  category_5.image.attach(io: File.open(image_path_5), filename: 'category_gradation.jpg')

tags = Tag.create(name: 'popular')

frame_alerts = FrameAlert.create([{ quantity: 10 }, { quantity: 20 }, { quantity: 30 }])
product_alerts = ProductAlert.create([{ quantity: 0 }, { quantity: 1 }, { quantity: 5 }])

frames = [
  { name: "8本/55cm 茶", kind: "長傘", inventory: 30, frame_alert_id: FrameAlert.find_by(quantity: 30).id },
  { name: "8本/55cm 黒", kind: "長傘", inventory: 30, frame_alert_id: FrameAlert.find_by(quantity: 30).id },
  { name: "8本/60cm 茶", kind: "長傘", inventory: 20, frame_alert_id: FrameAlert.find_by(quantity: 10).id },
  { name: "8本/60cm 黒", kind: "長傘", inventory: 15, frame_alert_id: FrameAlert.find_by(quantity: 10).id },
  { name: "8本/50cm 茶", kind: "折り畳み", inventory: 20, frame_alert_id: FrameAlert.find_by(quantity: 20).id }
]
frames.each do |frame|
  Frame.create(frame)
end

product_1 = Product.create!(
  name: "ブラックポルカドット傘", stock: 6, category_id: Category.find_by(name: "ポルカドット").id,
  frame_id: Frame.find_by(name: "8本/55cm 黒").id, product_alert_id: ProductAlert.find_by(quantity: 0).id
)
  image_path_6 = Rails.root.join('app/assets/images/polkadot_black.jpg')
  product_1.image.attach(io: File.open(image_path_6), filename: 'polkadot_black.jpg')

product_2 = Product.create!(
  name: "グリーンポルカドット傘", stock: 0, category_id: Category.find_by(name: "ポルカドット").id,
  frame_id: Frame.find_by(name: "8本/55cm 茶").id, product_alert_id: ProductAlert.find_by(quantity: 0).id
)
  image_path_7 = Rails.root.join('app/assets/images/polkadot_green.jpg')
  product_2.image.attach(io: File.open(image_path_7), filename: 'polkadot_green.jpg')

product_3 = Product.create!(
  name: "ネイビーポルカドット傘", stock: 0, category_id: Category.find_by(name: "ポルカドット").id,
  frame_id: Frame.find_by(name: "8本/55cm 茶").id, product_alert_id: ProductAlert.find_by(quantity: 0).id
)
  image_path_8 = Rails.root.join('app/assets/images/polkadot_navy.jpg')
  product_3.image.attach(io: File.open(image_path_8), filename: 'polkadot_navy.jpg')

product_4 = Product.create!(
  name: "レッドストライプ傘", stock: 5, category_id: Category.find_by(name: "ストライプ").id,
  frame_id: Frame.find_by(name: "8本/55cm 茶").id, product_alert_id: ProductAlert.find_by(quantity: 0).id
)
  image_path_9 = Rails.root.join('app/assets/images/stripe_red.jpg')
  product_4.image.attach(io: File.open(image_path_9), filename: 'stripe_red.jpg')

product_5 = Product.create!(
  name: "イエローストライプ傘", stock: 0, category_id: Category.find_by(name: "ストライプ").id,
  frame_id: Frame.find_by(name: "8本/60cm 茶").id, product_alert_id: ProductAlert.find_by(quantity: 0).id
)
  image_path_10 = Rails.root.join('app/assets/images/stripe_yellow.jpg')
  product_5.image.attach(io: File.open(image_path_10), filename: 'stripe_yellow.jpg')

product_6 = Product.create!(
  name: "グレーストライプ傘", stock: 0, category_id: Category.find_by(name: "ストライプ").id,
  frame_id: Frame.find_by(name: "8本/55cm 黒").id, product_alert_id: ProductAlert.find_by(quantity: 0).id
)
  image_path_11 = Rails.root.join('app/assets/images/stripe_gray.jpg')
  product_6.image.attach(io: File.open(image_path_11), filename: 'stripe_gray.jpg')

product_7 = Product.create!(
  name: "ピンクフラワー柄傘", stock: 0, category_id: Category.find_by(name: "フラワー").id,
  frame_id: Frame.find_by(name: "8本/60cm 黒").id, product_alert_id: ProductAlert.find_by(quantity: 0).id
)
  image_path_12 = Rails.root.join('app/assets/images/flower_pink.jpg')
  product_7.image.attach(io: File.open(image_path_12), filename: 'flower_pink.jpg')

product_8 = Product.create!(
  name: "オレンジフラワー柄傘", stock: 5, category_id: Category.find_by(name: "フラワー").id,
  frame_id: Frame.find_by(name: "8本/50cm 茶").id, product_alert_id: ProductAlert.find_by(quantity: 0).id
)
  image_path_13 = Rails.root.join('app/assets/images/flower_orange.jpg')
  product_8.image.attach(io: File.open(image_path_13), filename: 'flower_orange.jpg')

product_9 = Product.create!(
  name: "ブラウンフラワー柄傘", stock: 0, category_id: Category.find_by(name: "フラワー").id,
  frame_id: Frame.find_by(name: "8本/60cm 茶").id, product_alert_id: ProductAlert.find_by(quantity: 0).id
)
  image_path_14 = Rails.root.join('app/assets/images/flower_brown.jpg')
  product_9.image.attach(io: File.open(image_path_14), filename: 'flower_brown.jpg')

product_10 = Product.create!(
  name: "ジャングルアニマルプリント傘", stock: 0, category_id: Category.find_by(name: "アニマルプリント").id,
  frame_id: Frame.find_by(name: "8本/60cm 黒").id, product_alert_id: ProductAlert.find_by(quantity: 0).id
)
  image_path_15 = Rails.root.join('app/assets/images/animal_jungle.jpg')
  product_10.image.attach(io: File.open(image_path_15), filename: 'animal_jungle.jpg')

product_11 = Product.create!(
  name: "パープルアニマルプリント傘", stock: 5, category_id: Category.find_by(name: "アニマルプリント").id,
  frame_id: Frame.find_by(name: "8本/60cm 黒").id, product_alert_id: ProductAlert.find_by(quantity: 0).id
)
  image_path_16 = Rails.root.join('app/assets/images/animal_purple.jpg')
  product_11.image.attach(io: File.open(image_path_16), filename: 'animal_purple.jpg')

product_12 = Product.create!(
  name: "シルバーアニマルプリント傘", stock: 0, category_id: Category.find_by(name: "アニマルプリント").id,
  frame_id: Frame.find_by(name: "8本/50cm 茶").id, product_alert_id: ProductAlert.find_by(quantity: 0).id
)
  image_path_17 = Rails.root.join('app/assets/images/animal_silver.jpg')
  product_12.image.attach(io: File.open(image_path_17), filename: 'animal_silver.jpg')

product_13 = Product.create!(
  name: "ブルーグラデーション傘", stock: 0, category_id: Category.find_by(name: "グラデーション").id,
  frame_id: Frame.find_by(name: "8本/60cm 黒").id, product_alert_id: ProductAlert.find_by(quantity: 0).id
)
  image_path_18 = Rails.root.join('app/assets/images/gradation_blue.jpg')
  product_13.image.attach(io: File.open(image_path_18), filename: 'gradation_blue.jpg')

product_14 = Product.create!(
  name: "ホワイトグラデーション傘", stock: 5, category_id: Category.find_by(name: "グラデーション").id,
  frame_id: Frame.find_by(name: "8本/50cm 茶").id, product_alert_id: ProductAlert.find_by(quantity: 0).id
)
  image_path_19 = Rails.root.join('app/assets/images/gradation_white.jpg')
  product_14.image.attach(io: File.open(image_path_19), filename: 'gradation_white.jpg')

product_15 = Product.create!(
  name: "ゴールドグラデーション傘", stock: 0, category_id: Category.find_by(name: "グラデーション").id,
  frame_id: Frame.find_by(name: "8本/55cm 茶").id, product_alert_id: ProductAlert.find_by(quantity: 0).id
)
  image_path_20 = Rails.root.join('app/assets/images/gradation_gold.jpg')
  product_15.image.attach(io: File.open(image_path_20), filename: 'gradation_gold.jpg')

# タグ付けを作成
taggings = [
  { tag_id: Tag.find_by(name: '人気').id, product_id: Product.find_by(name: "ブラックポルカドット傘").id },
  { tag_id: Tag.find_by(name: '人気').id, product_id: Product.find_by(name: "レッドストライプ傘").id },
  { tag_id: Tag.find_by(name: '人気').id, product_id: Product.find_by(name: "オレンジフラワー柄傘").id },
  { tag_id: Tag.find_by(name: '人気').id, product_id: Product.find_by(name: "パープルアニマルプリント傘").id },
  { tag_id: Tag.find_by(name: '人気').id, product_id: Product.find_by(name: "ホワイトグラデーション傘").id }
]
taggings.each do |tagging|
  Tagging.create(tagging)
end
