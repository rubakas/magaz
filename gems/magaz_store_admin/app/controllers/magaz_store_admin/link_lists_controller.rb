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
      @link_list = MagazCore::AdminServices::LinkList::AddLinkList.new
    end

    def create
      service = MagazCore::AdminServices::LinkList::AddLinkList
                  .run(name: params[:link_list][:name],
                       handle: params[:link_list][:handle],
                       shop_id: current_shop.id)

      if service.valid?
        @link_list = service.result
        flash[:notice] = t('.notice_success')
        redirect_to link_list_path(@link_list)
      else
        @link_list = service
        render 'new'
      end
    end

    def update
      @link_list = current_shop.link_lists.friendly.find(params[:id])
      service = MagazCore::AdminServices::LinkList::ChangeLinkList
                  .run(id: @link_list.id,
                       name: params[:link_list][:name],
                       handle: params[:link_list][:handle],
                       shop_id: current_shop.id)

      if service.valid?
        @link_list = service.result
        flash[:notice] = t('.notice_success')
        redirect_to link_list_path(@link_list)
      else
        service.errors.full_messages.each do |msg|
          @link_list.errors.add(:base, msg)
        end
        render 'show'
      end
    end

    def destroy
      service = MagazCore::AdminServices::LinkList::DeleteLinkList
                  .run(shop_id: current_shop.id,
                       id: params[:id])
      flash[:notice] = t('.notice_success')
      redirect_to link_lists_path
    end
  end
end
