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
      @blog = current_shop.blogs.new(permitted_params[:blog])
      if @blog.save
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @blog,
                                                                   message: t('.message', action: t('.created'), subject: t('.blog'), user_name: full_name(user: current_user)),
                                                                   description: t('.description', action: t('.created'), subject: t('.blog')),
                                                                   path: blog_path(@blog),
                                                                   verb: t('.create'))
        flash[:notice] = t('.notice_success')
        redirect_to blog_path(@blog)
      else
        flash[:notice] = t('.notice_fail')
        render 'new'
      end
    end

    def update
      @blog = current_shop.blogs.friendly.find(params[:id])
      if @blog.update_attributes(permitted_params[:blog])
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @blog,
                                                                   message: t('.message', action: t('.updated'), subject: t('.blog'), user_name: full_name(user: current_user)),
                                                                   description: t('.description', action: t('.updated'), subject: t('.blog')),
                                                                   path: blog_path(@blog),
                                                                   verb: t('.update'))
        flash[:notice] = t('.notice_success')
        redirect_to blog_path(@blog)
      else
        render 'show'
      end
    end

    def destroy
      @blog = current_shop.blogs.friendly.find(params[:id])
      @blog.destroy
      @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @blog,
                                                                   message: t('.message', action: t('.deleted'), subject: t('.blog'), user_name: full_name(user: current_user)),
                                                                   description: t('.description', action: t('.deleted'), subject: t('.blog')),
                                                                   path: nil,
                                                                   verb: t('.destroy'))
      flash[:notice] = t('.notice_success')
      redirect_to blogs_path
    end

    private
    def full_name(user:)
      [user.first_name, user.last_name].map(&:capitalize).join(" ")
    end

    protected

    #TODO:  collection_ids are not guaranteed to belong to this shop!!!
    # https://github.com/josevalim/inherited_resources#strong-parameters
    def permitted_params
      { blog:
          params.fetch(:blog, {}).permit(:title, :page_title, :meta_description, :handle) }
    end

  end
end
