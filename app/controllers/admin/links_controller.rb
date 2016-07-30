class Admin::LinksController < Admin::ApplicationController
  include Concerns::Authenticable

  def index
    @link_list = LinkList.friendly.find(params[:link_list_id])
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
    service = AdminServices::Link::AddLink
              .new(link_list_id: params[:link_list_id], params: params[:link].permit!)
              .run
    @link_list = service.result.link_list
    @link = service.result
    if service.success?
      flash.now[:notice] = t('.notice_success')
      render 'show'
    else
      render 'new'
    end
  end

  def update
    service = AdminServices::Link::ChangeLink
              .new(id: params[:id], link_list_id: params[:link_list_id], params: params[:link].permit!)
              .run
    @link_list = service.link.link_list
    @link = service.result
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_link_list_path(@link_list)
    else
      render 'show'
    end
  end

  def destroy
    service = AdminServices::Link::DeleteLink
              .new(id: params[:id], link_list_id: params[:link_list_id])
              .run
    flash[:notice] = t('.notice_success')
    redirect_to admin_link_list_path(service.result.link_list)
  end
end
