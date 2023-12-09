class Product < ApplicationRecord
  belongs_to :frame
  belongs_to :product_alert
  belongs_to :category
end
