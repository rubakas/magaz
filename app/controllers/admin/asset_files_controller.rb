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
              .run(shop_id: current_shop.id,
                   name: params[:asset_file][:name],
                   file: params[:asset_file][:file])
    if service.valid?
      @file = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_asset_file_path(@file)
    else
      @file = service.datafile
      render 'new'
    end
  end

  def update
    service = AdminServices::AssetFile::ChangeAssetFile
                .run(id: params[:id],
                     name: params[:asset_file][:name],
                     file: params[:asset_file][:file],
                     shop_id: current_shop.id)
    if service.valid?
      @file = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_asset_files_path
    else
      @file = service.datafile
      render 'show'
    end
  end

  def destroy
    AdminServices::AssetFile::DeleteAssetFile
      .run(id: params[:id],
           shop_id: current_shop.id)
    flash[:notice] = t('.notice_success')
    redirect_to admin_asset_files_path
  end

end
