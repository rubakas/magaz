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
    service = AdminServices::Blog::AddBlog
              .new(shop_id: current_shop.id, params: params[:blog].permit!)
              .run
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
              .new( shop_id: current_shop.id,
                    blog_id: params[:id],
                    params: params[:blog].permit!)
              .run
    @blog = service.result
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_blog_path(@blog)
    else
      render 'show'
    end
  end

  def destroy
    AdminServices::Blog::DeleteBlog
    .new(id: params[:id], shop_id: current_shop.id)
    .run
    flash[:notice] = t('.notice_success')
    redirect_to admin_blogs_path
  end
end
