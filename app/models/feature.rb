class Feature < ApplicationRecord
  validates :name, :description, :price, presence: true
  belongs_to :category
  belongs_to :status

  has_one_attached :product_image
end
