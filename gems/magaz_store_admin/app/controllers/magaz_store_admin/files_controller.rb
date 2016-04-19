module MagazStoreAdmin
  class FilesController < ApplicationController
    include MagazCore::Concerns::Authenticable
    layout 'admin_settings'

    def index
      @files = current_shop.files.page(params[:page])
    end

    def show
      @file = current_shop.files.find(params[:id])
    end

    def new
      @file = current_shop.files.new
    end

    def create
      service = MagazCore::AdminServices::File::AddFile
                  .run(shop_id: current_shop.id,
                       name: params[:file][:name],
                       file: params[:file][:file])
      if service.valid?
        @file = service.result
        flash[:notice] = t('.notice_success')
        redirect_to file_path(@file)
      else
        @file = service
        render 'new'
      end
    end


    def update
      @file = current_shop.files.find(params[:id])
      if @file.update_attributes(permitted_params[:file])
        flash[:notice] = t('.notice_success')
        redirect_to files_path
      else
        redner 'show'
      end
    end

    def destroy
      @file = current_shop.files.find(params[:id])
      @file.destroy
      flash[:notice] = t('.notice_success')
      redirect_to files_path
    end

    protected

    def permitted_params
      { file:
          params.fetch(:file, {}).permit(:file, :name)}
    end
  end
end
