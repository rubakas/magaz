class Admin::AssetFilesController < Admin::ApplicationController
  include Concerns::Authenticable
  layout 'admin/admin_settings'

  def index
    @files = current_shop.asset_files.page(params[:page])
  end

  def show
    @file = current_shop.asset_files.find(params[:id])
  end

  def new
    @file = current_shop.asset_files.new
  end

  def create
    service = AdminServices::AssetFile::AddAssetFile
              .new(shop_id: current_shop.id, params: params[:asset_file].permit!)
              .run
    @file = service.result
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_asset_file_path(@file)
    else
      render 'new'
    end
  end

  def update
    service = AdminServices::AssetFile::ChangeAssetFile
              .new(id: params[:id], shop_id: current_shop.id, params: params[:asset_file].permit!)
              .run
    @file = service.result
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_asset_files_path
    else
      render 'show'
    end
  end

  def destroy
    AdminServices::AssetFile::DeleteAssetFile
    .new(id: params[:id], shop_id: current_shop.id)
    .run
    flash[:notice] = t('.notice_success')
    redirect_to admin_asset_files_path
  end

end
