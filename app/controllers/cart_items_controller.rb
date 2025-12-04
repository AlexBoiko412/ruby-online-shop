class CartItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    size = params[:size]

    # Додаємо у сесію (для простоти)
    session[:cart] ||= []
    session[:cart] << { product_id: product.id, size: size, quantity: 1 }

    redirect_to root_path, notice: "Додано #{product.name} (#{size})"
  end

  def destroy
    session[:cart] = []
    redirect_to root_path, notice: "Кошик очищено"
  end
end