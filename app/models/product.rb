class Product < ApplicationRecord

  validates :name, :description, :price, :brand, presence: true
  validates :price, numericality: { greater_than: 0 }

  has_many :product_sizes, dependent: :destroy
  has_many :sizes, through: :product_sizes

  def self.ransackable_attributes(auth_object = nil)
    %w[brand created_at description id name price updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[sizes product_sizes]
  end
end