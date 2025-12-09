class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_admin!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).includes(:sizes)

    case params[:sort]
    when "price_asc"
      @products = @products.order(price: :asc)
    when "price_desc"
      @products = @products.order(price: :desc)
    when "name"
      @products = @products.order(name: :asc)
    else
      @products = @products.order(created_at: :desc)
    end
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
end