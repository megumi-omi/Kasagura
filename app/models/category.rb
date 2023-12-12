class Category < ApplicationRecord
  has_one :product
  validates :name, :tag, length: { maximum: 50 }
end
