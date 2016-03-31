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
      @page = MagazCore::ShopServices::Page::AddPage.new
    end

    def create
      service = MagazCore::ShopServices::Page::AddPage
                  .run(title: params[:page][:title],
                       content: params[:page][:content],
                       page_title: params[:page][:page_title],
                       meta_description: params[:page][:meta_description],
                       handle: params[:page][:handle],
                       shop_id: current_shop.id)

      if service.valid?
        @page = service.result
        flash[:notice] = t('.notice_success')
        redirect_to page_path(@page)
      else
        @page = service
        render 'show'
      end
    end

    def update
      @page = current_shop.pages.friendly.find(params[:id])
      service = MagazCore::ShopServices::Page::ChangePage
                  .run(id: @page.id,
                       title: params[:page][:title],
                       shop_id: current_shop.id,
                       page_title: params[:page][:page_title],
                       meta_description: params[:page][:meta_description],
                       handle: params[:page][:handle],
                       content: params[:page][:content])

      if service.valid?
        @page = service.result
        flash[:notice] = t('.notice_success')
        redirect_to page_path(@page)
      else
        service.errors.full_messages.each do |msg|
          @page.errors.add(:base, msg)
        end
        render 'show'
      end
    end

    def destroy
      @page = current_shop.pages.friendly.find(params[:id])
      service = MagazCore::ShopServices::Page::DeletePage.run(id: @page.id)
      flash[:notice] = t('.notice_success')
      redirect_to pages_path
    end
  end
end
