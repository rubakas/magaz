module MagazStoreAdmin
  class LinksController < ApplicationController
    include MagazCore::Concerns::Authenticable

    def index
      @link_list = current_shop.link_lists.frieldly.find(params[:link_list_id])
      @links = @link_lists.links.page(params[:page])
    end

    def show
      @link_list = current_shop.link_lists.frinedly.find(params[:link_list_id])
      @link = @link_list.links.find(params[:id])
    end

    def new
      @link_list = current_shop.link_lists.friendly.find(params[:link_list_id])
      @link = @link_list.links.new
    end

    def create
      @link_list = current_shop.link_lists.friendly.find(params[:link_list_id])
      @link = @link_list.links.new(permitted_params[:link])
      if @link.save
        flash[:notice] = t('.notice_success')
        render 'show'
      else
        render 'new'
      end
    end

    def update
      @link_list = current_shop.link_lists.friendly.find(params[:link_list_id])
      @link = @link_list.links.find(params[:id])
      if @link.update_attributes(permitted_params[:link])
        flash[:notice] = t('.notice_success')
        redirect_to link_path(@link)
      else
        render 'show'
      end
    end

    def destroy
      @link_list = current_shop.link_lists.friendly.find(params[:link_list_id])
      @link = @link_list.links.find(params[:id])
      @link.destroy
      flash[:notice] = t('.notice_success')
      redirect_to link_list_path(@link_list)
    end

    protected

    def permitted_params
      { link:
          params.fetch(:link, {}).permit(:name, :link_type, :position, :link_list_id) }
    end
  end
end
