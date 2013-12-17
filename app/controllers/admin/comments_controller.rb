class Admin::CommentsController < ApplicationController
  include Authenticable
  before_action :set_comment, only: [:show, :update, :destroy]

  def index
    @comments = Comment.page(params[:page])
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
      if @comment.save
        redirect_to [:admin, @comment], notice: "Comment was successfully created"
      else
        render action: "new"
      end
  end

  def update
    if @comment.update(comment_params)
      redirect_to [:admin, @comment], notice: "Comment was successfully updated"
    else
      render action: "show"
    end
  end

  def destroy
    @comment.destroy
    redirect_to admin_comments_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:author, :email, :body)
    end
end