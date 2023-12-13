class Category < ApplicationRecord
  has_one :product
  validates :name, length: { maximum: 50 }
end
