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
      @comment = current_shop.articles.find_by(params[:id]).comments.new
    end

    def create
      service = MagazCore::AdminServices::Comment::AddComment
                  .run(author: params[:comment][:author],
                       email: params[:comment][:email],
                       body: params[:comment][:body],
                       article_id: params[:comment][:article_id],
                       blog_id: params[:comment][:blog_id])
      if service.valid?
        @comment = service.result
        flash[:notice] = t('.notice_success')
        redirect_to comment_url(@comment)
      else
        @comment = service.comment
        flash[:notice] = t('.notice_fail')
        render 'new'
      end
    end

    def update
      service = MagazCore::AdminServices::Comment::ChangeComment
                  .run(id: params[:id],
                       author: params[:comment][:author],
                       email: params[:comment][:email],
                       body: params[:comment][:body])
      if service.valid?
        @comment = service.result
        flash[:notice] = t('.notice_success')
        redirect_to comment_url(@comment)
      else
        @comment = service.comment
        flash[:notice] = t('.notice_fail')
        render 'show'
      end
    end

    def destroy
      service = MagazCore::AdminServices::Comment::DeleteComment.run(id: params[:id])
      flash[:notice] = t('.notice_success')
      redirect_to comments_url
    end
  end
end
