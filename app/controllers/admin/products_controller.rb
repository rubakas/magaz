class Admin::ProductsController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  #inherit_resources
  #actions :all, :except => [:edit]

  def index
    @products = current_shop.products.page(params[:page])
  end

  def show
    @product = current_shop.products.friendly.find(params[:id])
  end

  def new
    @product = current_shop.products.new
  end

  def create
    @product = current_shop.products.new(permitted_params[:product])
    if @product.save
      flash[:notice] = 'Product was successfully created.'
      redirect_to admin_product_path(@product)
    else
      render 'show'
    end
  end

  def update
    @product = current_shop.products.friendly.find(params[:id])
    if @product.update_attributes(permitted_params[:product])
      flash[:notice] = 'Product was successfully updated.'
      redirect_to admin_product_path(@product)
    else
      render 'show'
    end
  end

  def destroy
    @product = current_shop.products.friendly.find(params[:id])
    @product.destroy
    flash[:notice] = 'Product was successfully destroyed.'
    redirect_to admin_products_path
  end

  protected

  def begin_of_association_chain
    current_shop
  end

  def collection
    @products ||= end_of_association_chain.page(params[:page])
  end

  def resource
    @product ||= end_of_association_chain.friendly.find(params[:id])
  end

  #TODO:  collection_ids are not guaranteed to belong to this shop!!!
  # https://github.com/josevalim/inherited_resources#strong-parameters
  def permitted_params
    { product:
        params.fetch(:product, {}).permit(:name, :description, :price, :page_title, :meta_description, :handle, product_images_attributes: [:image, :_destroy, :id], collection_ids: []) }
  end
end
