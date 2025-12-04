class Product < ApplicationRecord

  validates :name, :description, :price, :brand, presence: true
  validates :price, numericality: { greater_than: 0 }

  has_many :product_sizes, dependent: :destroy
  has_many :sizes, through: :product_sizes

end