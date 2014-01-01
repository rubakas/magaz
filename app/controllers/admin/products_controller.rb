class Admin::ProductsController < ApplicationController
  include Authenticable
  inherit_resources
  actions :all, :except => [:edit]

  protected

  def begin_of_association_chain
    current_shop
  end

  def collection
    @products ||= end_of_association_chain.page(params[:page])
  end

  #TODO collection_ids are not guaranteed to belong to this shop!!!
  # https://github.com/josevalim/inherited_resources#strong-parameters
  def permitted_params
    { product: 
        params.fetch(:product, {}).permit(:name, :description, :price, collection_ids: []) }
  end
end
