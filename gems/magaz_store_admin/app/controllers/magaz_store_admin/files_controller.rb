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
      @file = current_shop.files.new(permitted_params[:file])
      if @file.save
        flash[:notice] = t('.notice_success')
        redirect_to file_path(@file)
      else
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
      MagazCore::AdminServices::File::DeleteFile
        .run(id: params[:id],
             shop_id: current_shop.id)
      flash[:notice] = t('.notice_success')
      redirect_to files_path
    end
  end
end
