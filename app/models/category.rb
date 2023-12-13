class Category < ApplicationRecord
  has_one :product
  has_one_attached :image
end
