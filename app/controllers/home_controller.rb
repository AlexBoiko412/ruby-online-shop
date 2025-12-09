class HomeController < ApplicationController
  def index
    @q = Product.ransack(params[:q])

    sort = params[:sort] || "newest"
    case sort
    when "price_asc"
      @products = @q.result(distinct: true).includes(:sizes).order(price: :asc)
    when "price_desc"
      @products = @q.result(distinct: true).includes(:sizes).order(price: :desc)
    when "name"
      @products = @q.result(distinct: true).includes(:sizes).order(name: :asc)
    else
      @products = @q.result(distinct: true).includes(:sizes).order(created_at: :desc)
    end
  end
end