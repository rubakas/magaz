module MagazStoreAdmin
  class PagesController < ApplicationController
    include MagazCore::Concerns::Authenticable

    def index
      @pages = current_shop.pages.page(params[:page])
    end

    def show
      @page = current_shop.pages.friendly.find(params[:id])
    end

    def new
      @page = current_shop.pages.new
    end

    def create
      @page = current_shop.pages.new(permitted_params[:page])
      if @page.save
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @page,
                                                                   message: t('.notice_success'),
                                                                   description: t('.notice_success'),
                                                                   path: page_path(@page),
                                                                   verb: 'create')
        flash[:notice] = t('.notice_success')
        redirect_to page_path(@page)
      else
        render 'show'
      end
    end

    def update
      @page = current_shop.pages.friendly.find(params[:id])
      if @page.update_attributes(permitted_params[:page])
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @page,
                                                                   message: t('.notice_success'),
                                                                   description: t('.notice_success'),
                                                                   path: page_path(@page),
                                                                   verb: 'update')
        flash[:notice] = t('.notice_success')
        redirect_to page_path(@page)
      else
        render 'show'
      end
    end

    def destroy
      @page = current_shop.pages.friendly.find(params[:id])
      @page.destroy
      @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @page,
                                                                   message: t('.notice_success'),
                                                                   description: t('.notice_success'),
                                                                   path: nil,
                                                                   verb: 'destroy')
      flash[:notice] = t('.notice_success')
      redirect_to pages_path
    end

    protected

    #TODO:  collection_ids are not guaranteed to belong to this shop!!!
    # https://github.com/josevalim/inherited_resources#strong-parameters
    def permitted_params
      { page: params.fetch(:page, {}).permit(:title, :content, :page_title, :meta_description, :handle) }
    end
  end
end
