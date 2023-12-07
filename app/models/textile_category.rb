class TextileCategory < ApplicationRecord
  has_one :product
  validates_length_of :name, maximum: 50
end
