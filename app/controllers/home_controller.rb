class HomeController < ApplicationController
  def index
    @q = Product.ransack(params[:q])

    per_page = case params[:per_page]
               when "24" then 24
               when "48" then 48
               when "all" then nil
               else 12
               end

    @products = @q.result(distinct: true)
                  .includes(:sizes)
                  .order(sort_order)
                  .page(params[:page])
                  .per(per_page)
  end

  private

  def sort_order
    case params[:sort]
    when "price_asc" then { price: :asc }
    when "price_desc" then { price: :desc }
    when "name" then { name: :asc }
    else { created_at: :desc }
    end
  end
end