class CartController < ApplicationController
  def add
    session[:cart] ||= []
    session[:cart] << { product_id: params[:product_id], size: params[:size], qty: 1 }
    redirect_to root_path, notice: "Додано у кошик!"
  end

  def show
  end

  def clear
    session[:cart] = nil
    redirect_to root_path, notice: "Кошик очищено"
  end
end