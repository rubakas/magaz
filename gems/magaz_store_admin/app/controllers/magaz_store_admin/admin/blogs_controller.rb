class Admin::BlogsController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  
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
    @blog = current_shop.blogs.new(permitted_params[:blog])
    if @blog.save
      flash[:notice] = 'Blog was successfully created.'
      redirect_to admin_blog_path(@blog)
    else
      flash[:error] = "Can't create such blog,try again please."
      render 'new'
    end
  end

  def update
    @blog = current_shop.blogs.friendly.find(params[:id])
    if @blog.update_attributes(permitted_params[:blog])
      flash[:notice] = 'Blog was successfully updated.'
      redirect_to admin_blog_path(@blog)
    else
      render 'show'
    end
  end

  def destroy
    @blog = current_shop.blogs.friendly.find(params[:id])
    @blog.destroy
    flash[:notice] = "Blog was destroyed."
    redirect_to admin_blogs_path
  end

  protected

  #TODO:  collection_ids are not guaranteed to belong to this shop!!!
  # https://github.com/josevalim/inherited_resources#strong-parameters
  def permitted_params
    { blog:
        params.fetch(:blog, {}).permit(:title, :page_title, :meta_description, :handle) }
  end

end
