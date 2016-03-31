module MagazStoreAdmin
  class LinksController < ApplicationController
    include MagazCore::Concerns::Authenticable

    def index
      @link_list = MagazCore::LinkList.find(params[:link_list_id])
      @links = @link_list.links.page(params[:page])
    end

    def show
      @link_list = current_shop.link_lists.friendly.find(params[:link_list_id])
      @link = @link_list.links.find(params[:id])
    end

    def new
      @link_list = current_shop.link_lists.friendly.find(params[:link_list_id])
      @link = @link_list.links.new
    end

    def create
      @link_list = current_shop.link_lists.friendly.find(params[:link_list_id])
      service = MagazCore::ShopServices::Link::AddLink
                  .run(name: params[:link][:name],
                       link_type: params[:link][:link_type],
                       position: params[:link][:position],
                       link_list_id: @link_list.id)

      if service.valid?
        @link = service.result
        flash[:notice] = t('.notice_success')
        render 'show'
      else
        @link = service
        render 'new'
      end
    end

    def update
      @link_list = current_shop.link_lists.friendly.find(params[:link_list_id])
      @link = @link_list.links.find(params[:id])
      service = MagazCore::ShopServices::Link::ChangeLink
                  .run(id: @link.id,
                       link_list_id: @link_list.id,
                       name: params[:link][:name],
                       link_type: params[:link][:link_type],
                       position: params[:link][:position])

      if service.valid?
        @link = service.result
        flash[:notice] = t('.notice_success')
        redirect_to link_list_path(@link_list)
      else
        service.errors.full_messages.each do |msg|
          @link.errors.add(:base, msg)
        end
        render 'show'
      end
    end

    def destroy
      @link_list = current_shop.link_lists.friendly.find(params[:link_list_id])
      @link = @link_list.links.find(params[:id])
      MagazCore::ShopServices::Link::DeleteLink.run(id: @link.id)
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
