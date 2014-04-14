class Admin::CollectionsController < Admin::ApplicationController
  include Authenticable
  inherit_resources
  actions :all, :except => [:edit]

  def update
    @collection = Collection.friendly.find(params[:id])
    update! do |success, failure|
      failure.html { render :show }
    end
  end

  def show
    @collection = Collection.friendly.find(params[:id])
  end

  def destroy
    @collection = Collection.friendly.find(params[:id]).destroy
    redirect_to admin_collections_path
  end


  protected

  def begin_of_association_chain
    current_shop
  end

  def collection
    @collections ||= end_of_association_chain.page(params[:page])
  end

  #TODO:  collection_ids are not guaranteed to belong to this shop!!!
  # https://github.com/josevalim/inherited_resources#strong-parameters
  def permitted_params
    { collection:
        params.fetch(:collection, {}).permit(:name, :description, :page_title, :meta_description, :handle) }
  end
end