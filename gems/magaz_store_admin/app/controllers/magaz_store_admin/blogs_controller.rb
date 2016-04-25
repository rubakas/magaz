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
      @blog = MagazCore::AdminServices::Blog::AddBlog.new
    end

    def create
      service = MagazCore::AdminServices::Blog::AddBlog
                .run(title: params[:blog][:title],
                     shop_id: current_shop.id,
                     page_title: params[:blog][:page_title],
                     handle: params[:blog][:handle],
                     meta_description: params[:blog][:meta_description])
      if service.valid?
        @blog = service.result
        flash[:notice] = t('.notice_success')
        redirect_to blog_path(@blog)
      else
        @blog = service
        flash[:notice] = t('.notice_fail')
        render 'new'
      end
    end

    def update
      @blog = current_shop.blogs.friendly.find(params[:id])
      service = MagazCore::AdminServices::Blog::ChangeBlog
                  .run(id: @blog.id,
                       title: params[:blog][:title],
                       shop_id: current_shop.id,
                       page_title: params[:blog][:page_title],
                       meta_description: params[:blog][:meta_description],
                       handle: params[:blog][:handle])
      if service.valid?
        @blog = service.result
        flash[:notice] = t('.notice_success')
        redirect_to blog_path(@blog)
      else
        service.errors.full_messages.each do |msg|
          @blog.errors.add(:base, msg)
        end
        render 'show'
      end
    end

    def destroy
      service = MagazCore::AdminServices::Blog::DeleteBlog.run(id: params[:id])
      flash[:notice] = t('.notice_success')
      redirect_to blogs_path
    end

  end
end
