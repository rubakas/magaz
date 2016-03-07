module MagazStoreAdmin
  class ArticlesController < ApplicationController
    include MagazCore::Concerns::Authenticable

    def index
      @articles = current_shop.articles.page(params[:page])
    end

    def show
      @article = current_shop.articles.friendly.find(params[:id])
    end

    def new
      @article = current_shop.articles.new
    end

    def create
      service = MagazCore::ShopServices::AddArticle.run(title: params[:title], content: params[:content],
                                                         blog_id: params[:blog_id], page_title: params[:page_title],
                                                         meta_description: params[:meta_description], handle: params[:handle])
      if service.valid?
        @article = service.result
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @article,
                                                                   topic: MagazCore::Webhook::Topics::CREATE_ARTICLE_EVENT,
                                                                   current_user: current_user)
        flash[:notice] = t('.notice_success')
        redirect_to article_url(@article)
      else
        flash[:notice] = t('.notice_fail')
        render 'new'
      end
    end

    def update
      service = MagazCore::ShopServices::ChangeArticle.run(id: params[:id], title: params[:title],
                                                           blog_id: params[:blog_id], page_title: params[:page_title],
                                                           meta_description: params[:meta_description], content: params[:content],
                                                           handle: params[:handle])
      if service.valid?
        @article = current_shop.articles.friendly.find(params[:id])
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @article,
                                                                   topic: MagazCore::Webhook::Topics::UPDATE_ARTICLE_EVENT,
                                                                   current_user: current_user)
        flash[:notice] = t('.notice_success')
        redirect_to article_url(@article)
      else
        flash[:notice] = t('.notice_fail')
        render 'show'
      end
    end

    def destroy
      #delete
      @article = current_shop.articles.friendly.find(params[:id])
      @article.destroy
      @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @article,
                                                                 topic: MagazCore::Webhook::Topics::DELETE_ARTICLE_EVENT,
                                                                 current_user: current_user)
      flash[:notice] = t('.notice_success')
      redirect_to articles_url
    end

    protected

    #TODO:  collection_ids are not guaranteed to belong to this shop!!!
    # https://github.com/josevalim/inherited_resources#strong-parameters
    def permitted_params
      { article:
          params.fetch(:article, {}).permit(:title, :content, :blog_id, :page_title, :meta_description, :handle) }
    end
  end
end
