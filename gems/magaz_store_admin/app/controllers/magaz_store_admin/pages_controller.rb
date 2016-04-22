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
      @page = MagazCore::AdminServices::Page::AddPage.new
    end

    def create
      service = MagazCore::AdminServices::Page::AddPage
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
      service = MagazCore::AdminServices::Page::ChangePage
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
      service = MagazCore::AdminServices::Page::DeletePage.run(id: params[:id])
      flash[:notice] = t('.notice_success')
      redirect_to pages_path
    end
  end
end
