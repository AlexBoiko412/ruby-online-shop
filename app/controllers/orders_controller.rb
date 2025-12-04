class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    return redirect_to root_path, alert: "Кошик порожній" unless session[:cart].present?

    order = current_user.orders.create!(status: "new", total_price: 0)
    total = 0

    session[:cart].each do |item|
      product = Product.find(item[:product_id])
      OrderItem.create!(order: order, product: product, size: item[:size], quantity: 1, price_at_purchase: product.price)
      total += product.price
    end

    order.update!(total_price: total)
    session[:cart] = nil

    redirect_to root_path, notice: "Замовлення №#{order.id} успішно оформлено! Дякуємо!"
  end
end