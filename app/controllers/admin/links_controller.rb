class Admin::LinksController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  #inherit_resources
  #defaults :resource_class => MagazCore::Link
  #nested_belongs_to :link_list
  #actions :all, :except => [:edit]

  def index
    @link_list = current_shop.link_lists.find(params[:link_list_id])
    @links = @link_lists.links.page(params[:page])
  end

  def show
    @link_list = current_shop.link_lists.find(params[:link_list_id])
    @link = @link_list.links.find(params[:id])
  end

  def new
    @link_list = current_shop.link_lists.find(params[:link_list_id])
    @link = @link_list.links.new
  end

  def create
    @link_list = current_shop.link_lists.find(params[:link_list_id])
    @link = @link_list.links.new(permitted_params[:link])
    if @link.save
      flash[:notice] = 'Link was successfully created.'
      render 'show'
    else
      render 'new'
    end
  end

  def update
    @link_list = current_shop.link_lists.find(params[:link_list_id])
    @link = @link_list.links.find(params[:id])
    if @link.update_attributes(permitted_params[:link])
      flash[:notice] = 'Link was successfully updated.'
      redirect_to admin_link_path(@link)
    else
      render 'show'
    end
  end

  def destroy
    @link_list = current_shop.link_lists.find(params[:link_list_id])
    @link = @link_list.links.find(params[:id])
    @link.destroy
    flash[:notice] = 'Link was successfully deleted.'
    render 'index'
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
