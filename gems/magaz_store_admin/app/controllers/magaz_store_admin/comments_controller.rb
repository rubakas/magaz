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
      @comment = @article.comments.create(permitted_params[:comment])
      if @comment.save
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @comment,
                                                                   message: t('.message', action: t('.created'), subject: t('.comment'), user_name: full_name(user: current_user)),
                                                                   description: t('.description', action: t('.created'), subject: t('.comment')),
                                                                   path: comment_url(@comment),
                                                                   verb: t('.create'))
        flash[:notice] = t('.notice_success')
        redirect_to comment_url(@comment)
      else
        flash[:notice] = t('.notice_fail')
        render 'new'
      end
    end

    def update
      @comment = current_shop.comments.find(params[:id])
      if @comment.update_attributes(permitted_params[:comment])
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @comment,
                                                                   message: t('.message', action: t('.updated'), subject: t('.comment'), user_name: full_name(user: current_user)),
                                                                   description: t('.description', action: t('.updated'), subject: t('.comment')),
                                                                   path: comment_url(@comment),
                                                                   verb: t('.update'))
        flash[:notice] = t('.notice_success')
        redirect_to comments_url
      else
        render 'show'
      end
    end

    def destroy
      @comment = current_shop.comments.find(params[:id])
      @comment.destroy
      @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @comment,
                                                                 message: t('.message', action: t('.deleted'), subject: t('.comment'), user_name: full_name(user: current_user)),
                                                                 description: t('.description', action: t('.deleted'), subject: t('.comment')),
                                                                 path: nil,
                                                                 verb: t('.destroy'))
      flash[:notice] = t('.notice_success')
      redirect_to comments_url
    end

    private
    def full_name(user:)
      [user.first_name, user.last_name].map(&:capitalize).join(" ")
    end

    protected

    #TODO:  collection_ids are not guaranteed to belong to this shop!!!
    # https://github.com/josevalim/inherited_resources#strong-parameters
    def permitted_params
      { comment:
          params.fetch(:comment, {}).permit(:author, :email, :body) }
    end
  end
end
