class Frame < ApplicationRecord

  belongs_to :frame_alert
  has_many :products
  validates :name, :kind, length: { maximum: 50 }
  accepts_nested_attributes_for :frame_alert, allow_destroy: true
  
end
