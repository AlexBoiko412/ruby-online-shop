class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  before_create :calculate_total

  private
  def calculate_total
    self.total_price = order_items.sum { |i| i.price_at_purchase * i.quantity }
  end
end