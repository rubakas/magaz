class Admin::CommentsController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  inherit_resources
  defaults :resource_class => MagazCore::Comment
  actions :all, :except => [:edit]

  def update
    update! do |success, failure|
      failure.html { render :show }
    end
  end

  protected

  def collection
    @comments ||= end_of_association_chain.page(params[:page])
  end

  #TODO:  collection_ids are not guaranteed to belong to this shop!!!
  # https://github.com/josevalim/inherited_resources#strong-parameters
  def permitted_params
    { comment:
        params.fetch(:comment, {}).permit(:author, :email, :body) }
  end
end