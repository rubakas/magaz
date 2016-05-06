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
      service = MagazCore::AdminServices::Webhook::AddWebhook
                  .run(shop_id: current_shop.id,
                       topic: params[:webhook][:topic],
                       format: params[:webhook][:format],
                       fields: params[:webhook][:fields],
                       address: params[:webhook][:address],
                       metafield_namespaces: params[:webhook][:metafield_namespaces])
      if service.valid?
        @webhook = service.result
        flash[:notice] = t('.notice_success')
        redirect_to webhook_url(@webhook)
      else
        @webhook = service.webhook
        flash[:error] = t('.notice_fail')
        render 'new'
      end
    end

    def update
      service = MagazCore::AdminServices::Webhook::ChangeWebhook
                  .run(id: params[:id],
                       shop_id: current_shop.id,
                       topic: params[:webhook][:topic],
                       format: params[:webhook][:format],
                       fields: params[:webhook][:fields],
                       address: params[:webhook][:address],
                       metafield_namespaces: params[:webhook][:metafield_namespaces])
      if service.valid?
        @webhook = service.result
        flash[:notice] = t('.notice_success')
        redirect_to webhook_url(@webhook)
      else
        @webhook = service.webhook
        flash[:notice] = t('.notice_fail')
        render 'show'
      end
    end

    def destroy
      MagazCore::AdminServices::Webhook::DeleteWebhook
                  .run(id: params[:id], shop_id: current_shop.id)
      flash[:notice] = t('.notice_success')
      redirect_to webhooks_url
    end

    private

    def full_name(user:)
      [user.first_name, user.last_name].map(&:capitalize).join(" ")
    end

  end
end
