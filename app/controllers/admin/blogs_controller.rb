class Admin::BlogsController < Admin::ApplicationController
  include Concerns::Authenticable

  def index
    @blogs = current_shop.blogs.page(params[:page])
  end

  def show
    @blog = current_shop.blogs.friendly.find(params[:id])
  end

  def new
    @blog = current_shop.blogs.new
  end

  def create
    service = AdminServices::Blog::AddBlog.new(shop_id: current_shop.id, params: blog_params).run
    @blog = service.result
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_blog_path(@blog)
    else
      flash[:notice] = t('.notice_fail')
      render 'new'
    end
  end

  def update
    service = AdminServices::Blog::ChangeBlog
              .run(id: params[:id],
                   shop_id: current_shop.id,
                   title: params[:blog][:title],
                   handle: params[:blog][:handle],
                   page_title: params[:blog][:page_title],
                   meta_description: params[:blog][:meta_description])
    if service.valid?
      @blog = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_blog_path(@blog)
    else
      @blog = service.blog
      render 'show'
    end
  end

  def destroy
    service = AdminServices::Blog::DeleteBlog
              .new(id: params[:id], shop_id: current_shop.id)
              .run
    flash[:notice] = t('.notice_success')
    redirect_to admin_blogs_path
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :handle, :page_title, :meta_description)
  end
end
