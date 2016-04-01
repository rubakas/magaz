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
      @article = MagazCore::AdminServices::Article::AddArticle.new
    end

    def create
      service = MagazCore::AdminServices::Article::AddArticle
                  .run(title: params[:article][:title],
                       content: params[:article][:content],
                       blog_id: params[:article][:blog_id],
                       page_title: params[:article][:page_title],
                       meta_description: params[:article][:meta_description],
                       handle: params[:article][:handle])
      if service.valid?
        @article = service.result
        flash[:notice] = t('.notice_success')
        redirect_to article_url(@article)
      else
        @article = service
        flash[:notice] = t('.notice_fail')
        render 'new'
      end
    end

    def update
      @article = current_shop.articles.friendly.find(params[:id])
      service = MagazCore::AdminServices::Article::ChangeArticle
                  .run(id: @article.id,
                       title: params[:article][:title],
                       blog_id: params[:article][:blog_id],
                       page_title: params[:article][:page_title],
                       meta_description: params[:article][:meta_description],
                       content: params[:article][:content],
                       handle: params[:article][:handle])
      if service.valid?
        @article = service.result
        flash[:notice] = t('.notice_success')
        redirect_to article_url(@article)
      else
        flash[:notice] = t('.notice_fail')
        service.errors.full_messages.each do |msg|
          @article.errors.add(:base, msg)
        end
        render 'show'
      end
    end

    def destroy
      @article = current_shop.articles.friendly.find(params[:id])
      service = MagazCore::AdminServices::Article::DeleteArticle.run(id: @article.id)
      flash[:notice] = t('.notice_success')
      redirect_to articles_url
    end
  end
end
