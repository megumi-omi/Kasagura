class Frame < ApplicationRecord
  belongs_to :frame_alert
  has_one :product
  validates :name, :color, :kind, length: { maximum: 50 }
end
