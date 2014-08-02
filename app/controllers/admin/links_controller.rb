class Admin::LinksController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  inherit_resources
  defaults :resource_class => MagazCore::Link
  nested_belongs_to :link_list
  actions :all, :except => [:edit]

  def update
    update! do |success, failure|
      failure.html { render :show }
    end
  end

  def destroy
    super do |format|
      format.html { redirect_to admin_link_list_url(@link_list) }
    end
  end

  protected
  def begin_of_association_chain
    current_shop
  end

  def collection
    @links ||= end_of_association_chain.page(params[:page])
  end

  def permitted_params
    { link:
        params.fetch(:link, {}).permit(:name, :link_type, :position, :link_list_id) }
  end
end
