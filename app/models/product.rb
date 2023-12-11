class Product < ApplicationRecord
  belongs_to :frame
  belongs_to :product_alert
  belongs_to :category
  has_one_attached :image
end
