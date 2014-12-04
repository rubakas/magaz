class Admin::CommentsController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  #inherit_resources
  #defaults :resource_class => MagazCore::Comment
  #actions :all, :except => [:edit]

  def index
    @comments = current_shop.comments.page(params[:page])
  end

  def show
    @comment = current_shop.comments.find(params[:id])
  end

  def new
    @article = current_shop.articles.find_by(params[:id])
    @comment = @article.comments.new
  end

  def create
    @article = current_shop.articles.find_by(params[:id])
    @comment = @article.comments.create(permitted_params[:comment])
    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
      redirect_to admin_comment_url(@comment)
    else
      flash[:error] = "Can't create such comment,try again please."
      render 'new'
    end
  end

  def update
    @comment = current_shop.comments.find(params[:id])
    if @comment.update_attributes(permitted_params[:comment])
      flash[:notice] = 'Comment was successfully updated.'
      redirect_to admin_comments_url
    else 
      render 'show'
    end
  end

  def destroy
    @comment = current_shop.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment was destroyed."
    redirect_to admin_comments_url
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