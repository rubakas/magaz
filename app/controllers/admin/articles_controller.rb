class Admin::ArticlesController < Admin::ApplicationController
  include Authenticable
  inherit_resources
  defaults :resource_class => MagazCore::Article
  actions :all, :except => [:edit]

  def update
    update! do |success, failure|
      failure.html { render :show }
    end
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
