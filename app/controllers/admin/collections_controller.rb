class Admin::CollectionsController < Admin::ApplicationController
  include Concerns::Authenticable

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
    service = AdminServices::Collection::AddCollection
              .new(shop_id: current_shop.id, params: params[:collection].permit!)
              .run
    if service.success?
      @collection = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_collection_url(@collection)
    else
      @collection = service.result
      flash[:error] = t('.notice_fail')
      render 'new'
    end
  end

  def update
    service = AdminServices::Collection::ChangeCollection
              .new(id: params[:id], shop_id: current_shop.id, params: params[:collection].permit!)
              .run
    @collection = service.result
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_collection_url(@collection)
    else
      render 'show'
    end
  end

  def destroy
    AdminServices::Collection::DeleteCollection
    .new(id: params[:id], shop_id: current_shop.id)
    .run
    flash[:notice] = t('.notice_success')
    redirect_to admin_collections_path
  end
end
