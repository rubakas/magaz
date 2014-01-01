class Admin::CollectionsController < ApplicationController
  include Authenticable
  inherit_resources
  actions :all, :except => [:edit]

  def update
    update! do |success, failure|
      failure.html { render :show }
    end
  end


  protected

  def begin_of_association_chain
    current_shop
  end

  def collection
    @collections ||= end_of_association_chain.page(params[:page])
  end

  #TODO collection_ids are not guaranteed to belong to this shop!!!
  # https://github.com/josevalim/inherited_resources#strong-parameters
  def permitted_params
    { collection: 
        params.fetch(:collection, {}).permit(:name, :description) }
  end
end