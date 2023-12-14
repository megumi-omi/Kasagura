class Category < ApplicationRecord
  has_many :product
  validates :name, length: { maximum: 50 }
end
