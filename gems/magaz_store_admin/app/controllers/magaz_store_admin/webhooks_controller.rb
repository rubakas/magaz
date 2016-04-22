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
        @webhook = current_shop.webhooks.find(params[:id])
        service.errors.full_messages.each do |msg|
          @webhook.errors.add(:base, msg)
        end
        render 'show'
      end
    end

    def destroy
      @webhook = current_shop.webhooks.find(params[:id])
      @webhook.destroy
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
