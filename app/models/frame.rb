class Frame < ApplicationRecord
  belongs_to :frame_alert
  has_many :products
  validates :name, :kind, length: { maximum: 50 }
end
