class Admin::ArticlesController < ApplicationController
  include Authenticable
  before_action :set_article, only: [:show, :update, :destroy]

  # GET /admin/articles
  def index
    @articles = Article.page(params[:page])
  end

  # GET /admin/articles/1
  def show
  end

  # GET /admin/articles/new
  def new
    @article = Article.build
  end

  # POST /articles/articles
  def create
    @article = Article.build(article_params)

    if @article.save
      redirect_to [:admin, @article], notice: "Blog Post was successfully created"
    else
      render action: "new"
    end
  end

  # PATCH/PUT /articles/articles/1
  def update
    if @article.update(article_params)
      redirect_to [:admin, @article], notice: "Blog Post was successfully updated"
    else
      render action: "show"
    end
  end

  # DELETE /articles/article/1
  def destroy
    @article.destroy
    redirect_to admin_articles_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = current_shop.articles.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content)
    end
end
