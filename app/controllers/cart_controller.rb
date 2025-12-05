class CartController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]

  def show
    @cart_items = cart_with_products
    @total = @cart_items.sum { |i| i[:product].price * i[:quantity] }
  end

  def add
    session[:cart] ||= []

    existing_item = session[:cart].find do |item|
      item["product_id"] == params[:product_id] && item["size"] == params[:size]
    end

    if existing_item
      existing_item["quantity"] = (existing_item["quantity"] || 1) + 1
    else
      session[:cart] << {
        "product_id" => params[:product_id],
        "size"       => params[:size],
        "quantity"   => 1
      }
    end

    redirect_to root_path, notice: "Додано до кошика!"
  end

  def remove
    return redirect_to cart_path if session[:cart].blank?

    session[:cart].reject! do |item|
      if item["product_id"] == params[:product_id] && item["size"] == params[:size]
        if item["quantity"].to_i > 1
          item["quantity"] -= 1
          false
        else
          true
        end
      else
        false
      end
    end

    redirect_to cart_path, notice: "Товар видалено з кошика"
  end

  def increase
    return redirect_to cart_path if session[:cart].blank?

    session[:cart].each do |item|
      if item["product_id"] == params[:product_id] && item["size"] == params[:size]
        item["quantity"] = (item["quantity"] || 1) + 1
        break
      end
    end

    redirect_to cart_path, notice: "Кількість збільшено"
  end

  def checkout
    return redirect_to cart_path, alert: "Кошик порожній" if session[:cart].blank?

    total = cart_with_products.sum { |i| i[:product].price * i[:quantity] }

    order = current_user.orders.create!(
      status: "new",
      total_price: total
    )

    session[:cart].each do |item|
      product = Product.find(item["product_id"])
      order.order_items.create!(
        product: product,
        size: item["size"],
        quantity: item["quantity"] || 1,
        price_at_purchase: product.price
      )
    end

    session[:cart] = nil
    redirect_to orders_path, notice: "Замовлення №#{order.id} успішно оформлено!"
  end

  private

  def cart_with_products
    return [] if session[:cart].blank?

    session[:cart].map do |item|
      {
        product:  Product.find(item["product_id"]),
        size:     item["size"],
        quantity: item["quantity"] || 1
      }
    end
  end

  def cart_total
    cart_with_products.sum { |i| i[:product].price * i[:quantity] }
  end
end