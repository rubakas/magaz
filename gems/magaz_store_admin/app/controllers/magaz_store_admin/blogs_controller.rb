module MagazStoreAdmin
  class BlogsController < ApplicationController
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
      service = MagazCore::AdminServices::Blog::AddBlog
                .run(shop_id: current_shop.id,
                     title: params[:blog][:title],
                     handle: params[:blog][:handle],
                     page_title: params[:blog][:page_title],
                     meta_description: params[:blog][:meta_description])
      if service.valid?
        @blog = service.result
        flash[:notice] = t('.notice_success')
        redirect_to blog_path(@blog)
      else
        @blog = service.blog
        flash[:notice] = t('.notice_fail')
        render 'new'
      end
    end

    def update
      service = MagazCore::AdminServices::Blog::ChangeBlog
                  .run(id: params[:id],
                       shop_id: current_shop.id,
                       title: params[:blog][:title],
                       handle: params[:blog][:handle],
                       page_title: params[:blog][:page_title],
                       meta_description: params[:blog][:meta_description])
      if service.valid?
        @blog = service.result
        flash[:notice] = t('.notice_success')
        redirect_to blog_path(@blog)
      else
        @blog = service.blog
        render 'show'
      end
    end

    def destroy
      service = MagazCore::AdminServices::Blog::DeleteBlog.run(id: params[:id],
                                                               shop_id: current_shop.id)
      flash[:notice] = t('.notice_success')
      redirect_to blogs_path
    end

  end
end
