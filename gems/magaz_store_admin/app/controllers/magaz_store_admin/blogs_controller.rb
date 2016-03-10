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
      @blog = MagazCore::ShopServices::AddBlog.new
    end

    def create
      service = MagazCore::ShopServices::AddBlog.run(title: params[:blog][:title], shop_id: current_shop.id,
                                                     page_title: params[:blog][:page_title], handle: params[:blog][:handle],
                                                     meta_description: params[:blog][:meta_description])
      if service.valid?
        @blog = service.result
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @blog,
                                                                   topic: MagazCore::Webhook::Topics::CREATE_BLOG_EVENT,
                                                                   current_user: current_user)
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
      service = MagazCore::ShopServices::ChangeBlog.run(id: @blog.id, title: params[:blog][:title],
                                                        shop_id: current_shop.id, page_title: params[:blog][:page_title],
                                                        meta_description: params[:blog][:meta_description], handle: params[:blog][:handle])
      if service.valid?
        @blog = service.result
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @blog,
                                                                   topic: MagazCore::Webhook::Topics::UPDATE_BLOG_EVENT,
                                                                   current_user: current_user)
        flash[:notice] = t('.notice_success')
        redirect_to blog_path(@blog)
      else
        render 'show'
      end
    end

    def destroy
      @blog = current_shop.blogs.friendly.find(params[:id])
      service = MagazCore::ShopServices::DeleteBlog.run(id: @blog.id)
      @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @blog,
                                                                 topic: MagazCore::Webhook::Topics::DELETE_BLOG_EVENT,
                                                                 current_user: current_user)
      flash[:notice] = t('.notice_success')
      redirect_to blogs_path
    end

  end
end
