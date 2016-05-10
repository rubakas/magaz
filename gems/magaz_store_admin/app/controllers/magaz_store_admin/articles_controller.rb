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
      service = MagazCore::AdminServices::Article::AddArticle
                  .run(title: params[:article][:title],
                       handle: params[:article][:handle],
                       content: params[:article][:content],
                       blog_id: params[:article][:blog_id],
                       page_title: params[:article][:page_title],
                       meta_description: params[:article][:meta_description])
      if service.valid?
        @article = service.result
        flash[:notice] = t('.notice_success')
        redirect_to article_url(@article)
      else
        @article = service.article
        flash[:notice] = t('.notice_fail')
        render 'new'
      end
    end

    def update
      service = MagazCore::AdminServices::Article::ChangeArticle
                  .run(id: params[:id],
                       title: params[:article][:title],
                       handle: params[:article][:handle],
                       blog_id: params[:article][:blog_id],
                       content: params[:article][:content],
                       page_title: params[:article][:page_title],
                       meta_description: params[:article][:meta_description])
      if service.valid?
        @article = service.result
        flash[:notice] = t('.notice_success')
        redirect_to article_url(@article)
      else
        @article = service.article
        flash[:notice] = t('.notice_fail')
        render 'show'
      end
    end

    def destroy
      service = MagazCore::AdminServices::Article::DeleteArticle.run(id: params[:id])
      flash[:notice] = t('.notice_success')
      redirect_to articles_url
    end

  end
end
