class Category < ApplicationRecord
  has_many :products
  has_one_attached :image
  validates :name, length: { maximum: 50 }, presence: true
end
