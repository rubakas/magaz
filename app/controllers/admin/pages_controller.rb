class Admin::PagesController < Admin::ApplicationController
  include Concerns::Authenticable

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
    service = AdminServices::Page::AddPage
                .run(title: params[:page][:title],
                     content: params[:page][:content],
                     page_title: params[:page][:page_title],
                     meta_description: params[:page][:meta_description],
                     handle: params[:page][:handle],
                     shop_id: current_shop.id)
    if service.valid?
      @page = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_page_path(@page)
    else
      @page = service.page
      flash.now[:notice] = t('.notice_fail')
      render 'show'
    end
  end

  def update
    service = AdminServices::Page::ChangePage
                .run(id: params[:id],
                     title: params[:page][:title],
                     shop_id: current_shop.id,
                     page_title: params[:page][:page_title],
                     meta_description: params[:page][:meta_description],
                     handle: params[:page][:handle],
                     content: params[:page][:content])
    if service.valid?
      @page = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_page_path(@page)
    else
      @page = service.page
      flash.now[:notice] = t('.notice_fail')
      render 'show'
    end
  end

  def destroy
    service = AdminServices::Page::DeletePage
                .run(id: params[:id], shop_id: current_shop.id)
    flash[:notice] = t('.notice_success')
    redirect_to admin_pages_path
  end

end
