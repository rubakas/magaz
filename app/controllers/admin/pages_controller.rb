class Admin::PagesController < ApplicationController
  include Authenticable
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /admin/pages
  # GET /admin/pages.json
  def index
    @pages = current_shop.pages.page(params[:page])
  end

  # GET /admin/pages/1
  # GET /admin/pages/1.json
  def show
  end

  # GET /admin/pages/new
  def new
    @page = current_shop.pages.build
  end

  # POST /admin/pages
  # POST /admin/pages.json
  def create
    @page = current_shop.pages.build(page_params)

    if @page.save
      redirect_to [:admin, @page], notice: "Page was successfully created"
    else
      render action: "new"
    end
  end

  # PATCH/PUT /admin/pages/1
  # PATCH/PUT /admin/pages/1.json
  def update
    if @page.update(page_params)
      redirect_to [:admin, @page], notice: "Page was successfully updated"
    else
      render action: "show"
    end
  end

  # DELETE /admin/pages/1
  # DELETE /admin/pages/1.json
  def destroy
    @page.destroy
    redirect_to admin_pages_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = current_shop.pages.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:name, :description)
    end
end
