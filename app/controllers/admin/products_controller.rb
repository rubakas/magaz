class Admin::ProductsController < ApplicationController
  include Authenticable
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /admin/products
  def index
    @products = current_shop.products.page(params[:page])
  end

  # GET /admin/products/new
  def new
    @product = current_shop.products.build
  end

  # GET /admin/products/1
  def show
  end

  # POST /admin/products
  def create
    @product = current_shop.products.build(product_params)
    if @product.save
      redirect_to [:admin, @product], notice: 'Product was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /admin/products/1
  # PATCH/PUT /admin/products/1.json
  def update
    if @product.update(product_params)
      redirect_to [:admin, @product], notice: 'Product was successfully updated.'
    else
      render action: 'show'
    end
  end

  # DELETE /admin/products/1
  # DELETE /admin/products/1.json
  def destroy
    @product.destroy
    redirect_to admin_products_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = current_shop.products.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description)
    end
end
