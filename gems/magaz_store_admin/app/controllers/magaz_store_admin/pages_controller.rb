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
        flash[:notice] = t('.notice_success')
        redirect_to page_path(@page)
      else
        render 'show'
      end
    end

    def update
      @page = current_shop.pages.friendly.find(params[:id])
      service = MagazCore::ShopServices::ChangePage.run(page: @page, title: params[:page][:title],
                                                        shop_id: current_shop.id, page_title: params[:page][:page_title],
                                                        meta_description: params[:page][:meta_description], handle: params[:page][:handle],
                                                        content: params[:page][:content])
      if service.valid?
        @page = service.result
        flash[:notice] = t('.notice_success')
        redirect_to page_path(@page)
      else
        render 'show'
      end
    end

    def destroy
      @page = current_shop.pages.friendly.find(params[:id])
      @page.destroy
      flash[:notice] = t('.notice_success')
      redirect_to pages_path
    end

    protected

    #TODO:  page_ids are not guaranteed to belong to this shop!!!
    # https://github.com/josevalim/inherited_resources#strong-parameters
    def permitted_params
      { page: params.fetch(:page, {}).permit(:title, :content, :page_title, :meta_description, :handle) }
    end
  end
end
