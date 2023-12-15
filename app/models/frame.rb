class Frame < ApplicationRecord
  belongs_to :frame_alert
  has_many :products
  accepts_nested_attributes_for :frame_alert, allow_destroy: true
  validates :name, :kind, length: { maximum: 50 }, presence: true
  with_options presence: true do
    validates :name
    validates :kind
    validates :inventory
  end
end
