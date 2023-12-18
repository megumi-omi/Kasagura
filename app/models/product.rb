class Product < ApplicationRecord
  belongs_to :frame
  belongs_to :product_alert
  belongs_to :category
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, source: :tag
  has_one_attached :image
  accepts_nested_attributes_for :taggings, allow_destroy: true
  validates :name, :stock, presence: true
  validates :image, presence: true

  # 在庫なし
  def self.stock_zero
    self.where(stock: 0)
  end

  # カテゴリ
  def self.category_stock(categories)
    self.joins(:category).where(categories: {id: categories})
  end

  # 種類
  def self.frame_stock(frames)
    self.joins(:frame).where(frames: {id: frames})
  end

  # カテゴリ・種類
  def self.category_and_frame_stock(categories, frames)
    self.joins(:category, :frame)
    .where(categories: {id: categories}, frames: {id: frames})
  end
  
end
