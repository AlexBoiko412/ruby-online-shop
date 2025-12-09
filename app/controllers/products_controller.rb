class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :require_admin!, only: [:new, :create, :edit, :update, :destroy]

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

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: "Товар успішно створено."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Товар успішно оновлено."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: "Товар успішно видалено."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: "Товар не знайдено."
  end

  def require_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Доступ заборонено."
    end
  end

  def product_params
    params.require(:product).permit(
      :name, :description, :price, :brand,
      photo_urls: [],
      size_ids: []
    ).tap do |p|
      p[:photo_urls] = p[:photo_urls].reject(&:blank?) if p[:photo_urls].present?
    end
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