module MagazStoreAdmin
  class CollectionsController < ApplicationController
    include MagazCore::Concerns::Authenticable

    def index
      @collections = current_shop.collections.page(params[:page])
    end

    def show
      @collection = current_shop.collections.friendly.find(params[:id])
    end

    def new
      @collection = current_shop.collections.new
    end

    def create
      @collection = current_shop.collections.new(permitted_params[:collection])
      if @collection.save
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @collection,
                                                                   topic: MagazCore::Webhook::Topics::CREATE_COLLECTION_EVENT,
                                                                   current_user: current_user)
        @webhook_service = MagazCore::ShopServices::EventWebhookRunner.call(event: @event_service.event,
                                                                            webhook: MagazCore::Webhook::Topics::CREATE_COLLECTION_EVENT)
        flash[:notice] = t('.notice_success')
        redirect_to collection_url(@collection)
      else
        flash[:error] = t('.notice_fail')
        render 'new'
      end
    end

    def update
      @collection = current_shop.collections.friendly.find(params[:id])
      if @collection.update_attributes(permitted_params[:collection])
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @collection,
                                                                   topic: MagazCore::Webhook::Topics::UPDATE_COLLECTION_EVENT,
                                                                   current_user: current_user)
        @webhook_service = MagazCore::ShopServices::EventWebhookRunner.call(event: @event_service.event,
                                                                            webhook: MagazCore::Webhook::Topics::UPDATE_COLLECTION_EVENT)
        flash[:notice] = t('.notice_success')
        redirect_to collection_url(@collection)
      else
        render 'show'
      end
    end

    def destroy
      @collection = current_shop.collections.friendly.find(params[:id])
      @collection.destroy
      @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @collection,
                                                                 topic: MagazCore::Webhook::Topics::DELETE_COLLECTION_EVENT,
                                                                 current_user: current_user)
      @webhook_service = MagazCore::ShopServices::EventWebhookRunner.call(event: @event_service.event,
                                                                          webhook: MagazCore::Webhook::Topics::UPDATE_COLLECTION_EVENT)
      flash[:notice] = t('.notice_success')
      redirect_to collections_url
    end

    protected

    #TODO:  collection_ids are not guaranteed to belong to this shop!!!
    # https://github.com/josevalim/inherited_resources#strong-parameters
    def permitted_params
      { collection:
          params.fetch(:collection, {}).permit(:name, :description, :page_title, :meta_description, :handle) }
    end
  end
end
