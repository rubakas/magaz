module MagazStoreAdmin
  class WebhooksController < ApplicationController
    layout 'admin_settings'
    include MagazCore::Concerns::Authenticable

    def index
      @webhooks = current_shop.webhooks.page(params[:page])
    end

    def show
      @webhook = current_shop.webhooks.find(params[:id])
    end

    def new
      @webhook = current_shop.webhooks.new
    end

    def create
      @webhook = current_shop.webhooks.new(permitted_params[:webhook])
      if @webhook.save
        flash[:notice] = t('.notice_success')
        redirect_to webhook_url(@webhook)
      else
        flash[:error] = t('.notice_fail')
        render 'new'
      end
    end

    def update
      @webhook = current_shop.webhooks.find(params[:id])
      if @webhook.update_attributes(permitted_params[:webhook])
        flash[:notice] = t('.notice_success')
        redirect_to webhook_url(@webhook)
      else
        render 'show'
      end
    end

    def destroy
      service = MagazCore::AdminServices::Webhook::DeleteWebhook
                  .run(id: params[:id], shop_id: current_shop.id)
      flash[:notice] = t('.notice_success')
      redirect_to webhooks_url
    end

    private

    def full_name(user:)
      [user.first_name, user.last_name].map(&:capitalize).join(" ")
    end

    protected

    #TODO:  webhook_ids are not guaranteed to belong to this shop!!!
    # https://github.com/josevalim/inherited_resources#strong-parameters
    def permitted_params
      { webhook:
          params.fetch(:webhook, {}).permit(:topic, :format, :address, :metafield_namespaces, :fields) }
    end
  end
end
