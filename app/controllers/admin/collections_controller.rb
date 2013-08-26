class Admin::CollectionsController < ApplicationController
  include Authenticable
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  # GET /admin/collections
  # GET /admin/collections.json
  def index
    @collections = current_shop.collections
  end

  # GET /admin/collections/1
  # GET /admin/collections/1.json
  def show
  end

  # GET /admin/collections/new
  def new
    @collection = current_shop.collections.build
  end

  # GET /admin/collections/1/edit
  def edit
  end

  # POST /admin/collections
  # POST /admin/collections.json
  def create
    @collection = current_shop.collections.build(collection_params)

    respond_to do |format|
      if @collection.save
        format.html { redirect_to [:admin, @collection], notice: 'Collection was successfully created.' }
        format.json { render action: 'show', status: :created, location: @collection }
      else
        format.html { render action: 'new' }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/collections/1
  # PATCH/PUT /admin/collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to [:admin, @collection], notice: 'Collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/collections/1
  # DELETE /admin/collections/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to admin_collections_url }
      format.json { head :no_content }
    end
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
