class Admin::CollectionsController < ApplicationController
  include Authenticable
  before_action :set_collection, only: [:show, :update, :destroy]

  # GET /admin/collections
  def index
    @collections = current_shop.collections.page(params[:page])
  end

  # GET /admin/collections/new
  def new
    @collection = current_shop.collections.build
  end

  # GET /admin/collections/1
  def show
  end

  # POST /admin/collections
  def create
    @collection = current_shop.collections.build(collection_params)

    if @collection.save
      redirect_to [:admin, @collection], notice: 'Collection was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /admin/collections/1
  def update
    if @collection.update(collection_params)
      redirect_to [:admin, @collection], notice: 'Collection was successfully updated.'
    else
      render action: 'show'
    end
  end

  # DELETE /admin/collections/1
  def destroy
    @collection.destroy
    redirect_to admin_collections_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = current_shop.collections.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      params.require(:collection).permit(:name, :description)
    end
end
