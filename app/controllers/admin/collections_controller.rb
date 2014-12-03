class Admin::CollectionsController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  #inherit_resources
  #actions :all, :except => [:edit]

  def index
    @collections = current_shop.collections.page(params[:page])
  end

  def show
    @collection = current_shop.collections.friendly.find(params[:id])
  end

  def new
    @collection = current_shop.collections.new
  end

  def create
    @collection = current_shop.collections.new(permitted_params[:collection])
    if @collection.save
      flash[:notice] = 'Collection was successfully created.'
      redirect_to admin_collection_url(@collection)
    else
      flash[:error] = "Can't create such collection,try again please."
      render 'new'
    end
  end

  def update
    @collection = current_shop.collections.friendly.find(params[:id])
    if @collection.update_attributes(permitted_params[:collection])
      flash[:notice] = 'Collection was successfully updated.'
      redirect_to admin_collection_url(@collection)
    else
      render 'show'
    end
  end

  def destroy
    @collection = current_shop.collections.friendly.find(params[:id])
    @collection.destroy
    flash[:notice] = "Collection was destroyed."
    redirect_to admin_collections_url
  end

  protected

  def begin_of_association_chain
    current_shop
  end

  def collection
    @collections ||= end_of_association_chain.page(params[:page])
  end

  def resource
    @collection ||= end_of_association_chain.friendly.find(params[:id])
  end

  #TODO:  collection_ids are not guaranteed to belong to this shop!!!
  # https://github.com/josevalim/inherited_resources#strong-parameters
  def permitted_params
    { collection:
        params.fetch(:collection, {}).permit(:name, :description, :page_title, :meta_description, :handle) }
  end
end