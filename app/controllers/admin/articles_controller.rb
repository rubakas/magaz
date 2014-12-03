class Admin::ArticlesController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  #inherit_resources
  #defaults :resource_class => MagazCore::Article
  #actions :all, :except => [:edit]

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
    @article = current_shop.articles.new(permitted_params[:article])
    if @article.save
      flash[:notice] = 'Article was successfully created.'
      redirect_to admin_article_url(@article)
    else
      flash[:error] = "Can't create such article,try again please."
      render 'new'
    end
  end

  def update
    @article = current_shop.articles.friendly.find(params[:id])
    if @article.update_attributes(permitted_params[:article])
      flash[:notice] = 'Article was successfully updated.'
      redirect_to admin_article_url(@article)
    else 
      render 'show'
    end
  end

  def destroy
    @article = current_shop.articles.friendly.find(params[:id])
    @article.destroy
    flash[:notice] = "Article was destroyed"
    redirect_to admin_articles_url
  end

  protected

  def collection
    @articles ||= end_of_association_chain.page(params[:page])
  end

  def resource
    @article ||= end_of_association_chain.friendly.find(params[:id])
  end

  #TODO:  collection_ids are not guaranteed to belong to this shop!!!
  # https://github.com/josevalim/inherited_resources#strong-parameters
  def permitted_params
    { article:
        params.fetch(:article, {}).permit(:title, :content, :blog_id, :page_title, :meta_description, :handle) }
  end
end
