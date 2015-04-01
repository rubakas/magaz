class Admin::FilesController < ApplicationController
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
      flash[:notice] = 'File was successfully created.'
      redirect_to admin_file_path(@file)
    else
      render 'new'
    end
  end


  def update
    @file = current_shop.files.find(params[:id])
    if @file.update_attributes(permitted_params[:file])
      flash[:notice] = 'File was successfully updated.'
      redirect_to admin_files_path
    else
      redner 'show'
    end
  end

  def destroy
    @file = current_shop.files.find(params[:id])
    @file.destroy
    flash[:notice] = 'File was successfully deleted.'
    redirect_to admin_files_path
  end

  protected

  def permitted_params
    { file:
        params.fetch(:file, {}).permit(:file, :name)}
  end
end
