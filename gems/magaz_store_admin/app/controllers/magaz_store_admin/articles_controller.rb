module MagazStoreAdmin
  class ArticlesController < ApplicationController
    include MagazCore::Concerns::Authenticable

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
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @article,
                                                                   message: I18n.t('magaz_store_admin.events.message', action: t('.created'), subject: t('.article'), user_name: current_user.full_name),
                                                                   verb: t('.create'),
                                                                   webhook: nil)
        flash[:notice] = t('.notice_success')
        redirect_to article_url(@article)
      else
        flash[:notice] = t('.notice_fail')
        render 'new'
      end
    end

    def update
      @article = current_shop.articles.friendly.find(params[:id])
      if @article.update_attributes(permitted_params[:article])
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @article,
                                                                   message: I18n.t('magaz_store_admin.events.message', action: t('.updated'), subject: t('.article'), user_name: current_user.full_name),
                                                                   verb: t('.update'),
                                                                   webhook: nil)
        flash[:notice] = t('.notice_success')
        redirect_to article_url(@article)
      else
        flash[:notice] = t('.notice_fail')
        render 'show'
      end
    end

    def destroy
      @article = current_shop.articles.friendly.find(params[:id])
      @article.destroy
      @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @article,
                                                                 message: I18n.t('magaz_store_admin.events.message', action: t('.deleted'), subject: t('.article'), user_name: current_user.full_name),
                                                                 verb: t('.destroy'),
                                                                 webhook: nil)
      flash[:notice] = t('.notice_success')
      redirect_to articles_url
    end

    protected

    #TODO:  collection_ids are not guaranteed to belong to this shop!!!
    # https://github.com/josevalim/inherited_resources#strong-parameters
    def permitted_params
      { article:
          params.fetch(:article, {}).permit(:title, :content, :blog_id, :page_title, :meta_description, :handle) }
    end
  end
end
