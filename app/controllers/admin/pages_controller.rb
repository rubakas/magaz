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
              .new(shop_id: current_shop.id, params: params[:page].permit!)
              .run
    @page = service.result
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_page_path(@page)
    else
      flash.now[:notice] = t('.notice_fail')
      render 'show'
    end
  end

  def update
    service = AdminServices::Page::ChangePage
              .new(id: params[:id],
                   shop_id: current_shop.id,
                   params: params[page].permit!)
              .run
    @page = service.result
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_page_path(@page)
    else
      flash.now[:notice] = t('.notice_fail')
      render 'show'
    end
  end

  def destroy
    AdminServices::Page::DeletePage
    .new(id: params[:id], shop_id: current_shop.id)
    .run
    flash[:notice] = t('.notice_success')
    redirect_to admin_pages_path
  end

end
