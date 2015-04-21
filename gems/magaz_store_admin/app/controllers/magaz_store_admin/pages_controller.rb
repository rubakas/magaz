module MagazStoreAdmin
  class PagesController < ApplicationController
    include MagazCore::Concerns::Authenticable

    def index
      @pages = current_shop.pages.page(params[:page])
    end

    def show
      @page = current_shop.pages.friendly.find(params[:id])
    end

    def new
      @page = current_shop.pages.new
    end

    def create
      @page = current_shop.pages.new(permitted_params[:page])
      if @page.save
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @page,
                                                                   message: t('.message', action: t('.created'), subject: t('.page'), user_name: full_name(user: current_user)),
                                                                   description: t('.description', action: t('.created'), subject: t('.page')),
                                                                   path: page_path(@page),
                                                                   verb: t('.create'))
        flash[:notice] = t('.notice_success')
        redirect_to page_path(@page)
      else
        render 'show'
      end
    end

    def update
      @page = current_shop.pages.friendly.find(params[:id])
      if @page.update_attributes(permitted_params[:page])
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @page,
                                                                   message: t('.message', action: t('.updated'), subject: t('.page'), user_name: full_name(user: current_user)),
                                                                   description: t('.description', action: t('.updated'), subject: t('.page')),
                                                                   path: page_path(@page),
                                                                   verb: t('.update'))
        flash[:notice] = t('.notice_success')
        redirect_to page_path(@page)
      else
        render 'show'
      end
    end

    def destroy
      @page = current_shop.pages.friendly.find(params[:id])
      @page.destroy
      @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @page,
                                                                 message: t('.message', action: t('.deleted'), subject: t('.page'), user_name: full_name(user: current_user)),
                                                                 description: t('.description', action: t('.deleted'), subject: t('.page')),
                                                                 path: nil,
                                                                 verb: t('.destroy'))
      flash[:notice] = t('.notice_success')
      redirect_to pages_path
    end

    private
    def full_name(user:)
      [user.first_name, user.last_name].map(&:capitalize).join(" ")
    end

    protected

    #TODO:  page_ids are not guaranteed to belong to this shop!!!
    # https://github.com/josevalim/inherited_resources#strong-parameters
    def permitted_params
      { page: params.fetch(:page, {}).permit(:title, :content, :page_title, :meta_description, :handle) }
    end
  end
end
