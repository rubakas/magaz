class Admin::PagesController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  #inherit_resources
  #actions :all, :except => [:edit]

  def index
    @pages = current_shop.pages.page(params[:page])
  end

  def show
    @page = current_shop.pages.friendly.find(params[:id])
  end

  def new
    @page = current_shop.pages.new
  end

  def create
    @page = current_shop.pages.new(permitted_params[:page])
    if @page.save
      flash[:notice] = 'Page was successfully created.'
      redirect_to admin_page_path(@page)
    else 
      render 'show'
    end
  end

  def update
    @page = current_shop.pages.friendly.find(params[:id])
    if @page.update_attributes(permitted_params[:page])
      flash[:notice] = 'Page was successfully updated.'
      redirect_to admin_page_path(@page)
    else
      render 'show'
    end
  end

  def destroy
    @page = current_shop.pages.friendly.find(params[:id])
    @page.destroy
    flash[:notice] = 'Page was successfully deleted.'
    redirect_to admin_pages_path
  end

  protected

  def begin_of_association_chain
    current_shop
  end

  def collection
    @pages ||= end_of_association_chain.page(params[:page])
  end

  def resource
    @page ||= end_of_association_chain.friendly.find(params[:id])
  end

  #TODO:  collection_ids are not guaranteed to belong to this shop!!!
  # https://github.com/josevalim/inherited_resources#strong-parameters
  def permitted_params
    { page: params.fetch(:page, {}).permit(:title, :content, :page_title, :meta_description, :handle) }
  end
end
