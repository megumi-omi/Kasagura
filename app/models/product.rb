class Product < ApplicationRecord
  belongs_to :frame
  belongs_to :product_alert
  belongs_to :category
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, source: :product
  has_one_attached :image
  accepts_nested_attributes_for :taggings, allow_destroy: true
  with_options presence: true do
    validates :name
    validates :stock
    validates :category_id
    validates :frame_id
    validates :product_alert_id
  end
end
