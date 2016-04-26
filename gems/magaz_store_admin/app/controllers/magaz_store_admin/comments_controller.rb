module MagazStoreAdmin
  class CommentsController < ApplicationController
    include MagazCore::Concerns::Authenticable

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
      service = MagazCore::AdminServices::Comment::AddComment
                  .run(author: params[:comment][:author],
                       email: params[:comment][:email],
                       body: params[:comment][:body],
                       article_id: @article.id,
                       blog_id: @article.blog.id)
      if service.valid?
        @comment = service.result
        flash[:notice] = t('.notice_success')
        redirect_to comment_url(@comment)
      else
        @comment = service
        flash[:notice] = t('.notice_fail')
        render 'new'
      end
    end

    def update
      @comment = current_shop.comments.find(params[:id])
      service = MagazCore::AdminServices::Comment::ChangeComment
                  .run(id: @comment.id,
                       author: params[:comment][:author],
                       email: params[:comment][:email],
                       body: params[:comment][:body])
      if service.valid?
        @comment = service.result
        flash[:notice] = t('.notice_success')
        redirect_to comment_url(@comment)
      else
        flash[:notice] = t('.notice_fail')
        service.errors.full_messages.each do |msg|
          @comment.errors.add(:base, msg)
        end
        render 'show'
      end
    end

    def destroy
      service = MagazCore::AdminServices::Comment::DeleteComment.run(id: params[:id])
      redirect_to comments_url
      flash[:notice] = t('.notice_success')
    end
  end
end
