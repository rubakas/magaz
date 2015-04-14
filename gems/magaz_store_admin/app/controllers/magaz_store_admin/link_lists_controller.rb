module MagazStoreAdmin
class LinkListsController < ApplicationController
  include MagazCore::Concerns::Authenticable

  def index
    @link_lists = current_shop.link_lists.page(params[:page])
  end

  def show
    @link_list = current_shop.link_lists.friendly.find(params[:id])
  end

  def new
    @link_list = current_shop.link_lists.new
  end

  def create
    @link_list = current_shop.link_lists.new(permitted_params[:link_list])
    if @link_list.save
      flash[:notice] = t('.notice_success')
      redirect_to link_list_path(@link_list)
    else
      render 'new'
    end
  end

  def update
    @link_list = current_shop.link_lists.friendly.find(params[:id])
    if @link_list.update_attributes(permitted_params[:link_list])
      flash[:notice] = t('.notice_success')
      redirect_to link_list_path(@link_list)
    else
      render 'show'
    end
  end

  def destroy
    @link_list = current_shop.link_lists.friendly.find(params[:id])
    @link_list.destroy
    flash[:notice] = t('.notice_success')
    redirect_to link_lists_path
  end

  protected

  def permitted_params
    { link_list:
        params.fetch(:link_list, {}).permit(:name, :handle, :links_attributes => [:name, :position, :link_type, :link_list_id]) }
  end
end
end
