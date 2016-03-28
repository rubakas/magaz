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
      service = MagazCore::ShopServices::AddComment.run(author: params[:comment][:author], email: params[:comment][:email],
                                                        body: params[:comment][:body], article_id: params[:comment][:article_id],
                                                        blog_id: params[:comment][:blog_id])
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
      service = MagazCore::ShopServices::ChangeComment.run(id: @comment.id, author: params[:comment][:author],
                                                          email: params[:comment][:email],
                                                          body: params[:comment][:body])
      if service.valid?
        @comment = service.result
        flash[:notice] = t('.notice_success')
        redirect_to comments_url
      else
        flash[:notice] = t('.notice_fail')
        service.errors.full_messages.each do |msg|
          @comment.errors.add(:base, msg)
        end
        render 'show'
      end
    end

    def destroy
      @comment = current_shop.comments.find(params[:id])
      service = MagazCore::ShopServices::DeleteComment.run(id: @comment.id)
      flash[:notice] = t('.notice_success')
      redirect_to comments_url
    end
  end
end
