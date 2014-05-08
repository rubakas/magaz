class Admin::CheckoutsController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  inherit_resources
  actions :all, :except => [:create, :edit, :new]

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
    @checkouts ||= end_of_association_chain.page(params[:page])
  end


  #TODO:  collection_ids are not guaranteed to belong to this shop!!!
  # https://github.com/josevalim/inherited_resources#strong-parameters
  def permitted_params
    { checkout:
        params.fetch(:checkout, {}).permit()}
  end
end
