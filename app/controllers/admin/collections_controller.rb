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
    service = AdminServices::Collection::AddCollection.new(shop_id: current_shop.id, params: params[:collection]).run
    if service.success?
      @collection = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_collection_url(@collection)
    else
      @collection = service.collection
      flash[:error] = t('.notice_fail')
      render 'new'
    end
  end

  def update
    service = AdminServices::Collection::ChangeCollection
              .run(id: params[:id],
                   name: params[:collection][:name],
                   shop_id: current_shop.id,
                   page_title: params[:collection][:page_title],
                   meta_description: params[:collection][:meta_description],
                   handle: params[:collection][:handle],
                   description: params[:collection][:description])

    if service.valid?
      @collection = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_collection_url(@collection)
    else
      @collection = service.collection
      render 'show'
    end
  end

  def destroy
    service = AdminServices::Collection::DeleteCollection
                .run(id: params[:id], shop_id: current_shop.id)
    flash[:notice] = t('.notice_success')
    redirect_to admin_collections_path
  end
end
