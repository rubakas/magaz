class Admin::LinkListsController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
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
    @link_lists ||= end_of_association_chain.page(params[:page])
  end

  def resource
    @link_list  ||= end_of_association_chain.find(params[:id])
  end

  def permitted_params
    { link_list:
        params.fetch(:link_list, {}).permit(:name, :handle, :links_attributes => [:name, :position, :link_type, :link_list_id]) }
  end
end
