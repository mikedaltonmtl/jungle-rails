class Product < ApplicationRecord
  mount_uploader :image, ProductImageUploader

  belongs_to :category

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  monetize :price_cents, numericality: true, allow_nil: true

end
