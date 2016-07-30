class Admin::LinkListsController < Admin::ApplicationController
  include Concerns::Authenticable

  def index
    @link_lists = current_shop.link_lists.page(params[:page])
  end

  def show
    @link_list = current_shop.link_lists.friendly.find(params[:id])
  end

  def new
    @link_list = current_shop.link_lists.new
  end

  def create
    service = AdminServices::LinkList::AddLinkList
              .new(shop_id: current_shop.id, params: params[:link_list].permit!)
              .run()
    if service.success?
      @link_list = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_link_list_path(@link_list)
    else
      @link_list = service.result
      flash.now[:notice] = t('.notice_fail')
      render 'new'
    end
  end

  def update
    service = AdminServices::LinkList::ChangeLinkList
              .new(id: params[:id], shop_id: current_shop.id, params: params[:link_list].permit!)
              .run
    @link_list = service.result
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_link_list_path(@link_list)
    else
      flash.now[:notice] = t('.notice_fail')
      render 'show'
    end
  end

  def destroy
    AdminServices::LinkList::DeleteLinkList
    .new(id: params[:id], shop_id: current_shop.id)
    .run
    flash[:notice] = t('.notice_success')
    redirect_to admin_link_lists_path
  end
end
