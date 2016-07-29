class Admin::ArticlesController < Admin::ApplicationController
  include Concerns::Authenticable

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
    service = AdminServices::Article::AddArticle
              .new(blog_id: params[:article][:blog_id], params: article_params)
              .run
    @article = service.result
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_article_url(@article)
    else
      flash[:notice] = t('.notice_fail')
      render 'new'
    end
  end

  def update
    service = AdminServices::Article::ChangeArticle
              .new( blog_id: params[:article][:blog_id],
                    article_id: params[:id],
                    params: params[:article].permit!)
              .run
    if service.success?
      @article = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_article_url(@article)
    else
      @article = service.result
      flash[:notice] = t('.notice_fail')
      render 'show'
    end
  end

  def destroy
    service = AdminServices::Article::DeleteArticle.run(id: params[:id])
    flash[:notice] = t('.notice_success')
    redirect_to admin_articles_url
  end

  private

  def article_params
    params.require(:article).permit(:title, :handle, :content, :page_title, :meta_description)
  end
end
