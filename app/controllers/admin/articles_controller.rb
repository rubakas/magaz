class Admin::ArticlesController < Admin::ApplicationController
  include Authenticable
  inherit_resources
  actions :all, :except => [:edit]

  def update
    @article = Article.friendly.find(params[:id])
    update! do |success, failure|
      failure.html { render :show }
    end
  end

  def show
    @article = Article.friendly.find(params[:id])
  end

  protected

  def collection
    @articles ||= end_of_association_chain.page(params[:page])
  end

  #TODO:  collection_ids are not guaranteed to belong to this shop!!!
  # https://github.com/josevalim/inherited_resources#strong-parameters
  def permitted_params
    { article:
        params.fetch(:article, {}).permit(:title, :content, :blog_id, :page_title, :meta_description, :handle) }
  end
end
