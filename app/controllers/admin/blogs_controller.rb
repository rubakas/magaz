class Admin::BlogsController < ApplicationController
  include Authenticable
  before_action :set_blog, only: [:show, :update, :destroy]

  # GET /admin/blogs
  def index
    @blogs = current_shop.blogs.page(params[:page])
  end

  # GET /admin/blogs/1
  def show
  end

  # GET /admin/blogs/new
  def new
    @blog = current_shop.blogs.build
  end

  # POST /admin/blogs
  def create
    @blog = current_shop.blogs.build(blog_params)

    if @blog.save
      redirect_to [:admin, @blog], notice: "Blog was successfully created"
    else
      render action: "new"
    end
  end

  # PATCH/PUT /admin/blogs/1
  def update
    if @blog.update(blog_params)
      redirect_to [:admin, @blog], notice: "Blog was successfully updated"
    else
      render action: "show"
    end
  end

  # DELETE /admin/blog/1
  def destroy
    @blog.destroy
    redirect_to admin_blogs_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = current_shop.blogs.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title)
    end
end
