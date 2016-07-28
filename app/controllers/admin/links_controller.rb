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
    service = AdminServices::Link::AddLink.new(link_list_id: params[:link_list_id], params: link_params).run
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
                .run(id: params[:id],
                     link_list_id: params[:link_list_id],
                     name: params[:link][:name],
                     link_type: params[:link][:link_type],
                     position: params[:link][:position])
    @link_list = service.link.link_list
    if service.valid?
      @link = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_link_list_path(@link_list)
    else
      @link = service.link
      render 'show'
    end
  end

  def destroy
    service = AdminServices::Link::DeleteLink
                .run(id: params[:id], link_list_id: params[:link_list_id])
    flash[:notice] = t('.notice_success')
    redirect_to admin_link_list_path(service.link_list)
  end

  private

  def link_params
    params.require(:link).permit(:name, :link_type, :position)
  end
end
