class Admin::WebhooksController < Admin::ApplicationController
  layout 'admin/admin_settings'
  include Concerns::Authenticable

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
    service = AdminServices::Webhook::AddWebhook
              .new(shop_id: current_shop.id, webhook_params: {
                   topic: params[:webhook][:topic],
                   format: params[:webhook][:format],
                   fields: params[:webhook][:fields],
                   address: params[:webhook][:address],
                   metafield_namespaces: params[:webhook][:metafield_namespaces] }
                  )
              .run
    @webhook = service.webhook
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_webhook_url(@webhook)
    else
      flash[:error] = t('.notice_fail')
      render 'new'
    end
  end

  def update
    service = AdminServices::Webhook::ChangeWebhook
              .new(shop_id: current_shop.id, webhook_params: {
                    id: params[:id],
                    topic: params[:webhook][:topic],
                    format: params[:webhook][:format],
                    fields: params[:webhook][:fields],
                    address: params[:webhook][:address],
                    metafield_namespaces: params[:webhook][:metafield_namespaces]})
              .run
    @webhook = service.webhook
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_webhook_url(@webhook)
    else
      flash[:notice] = t('.notice_fail')
      render 'show'
    end
  end

  def destroy
    AdminServices::Webhook::DeleteWebhook.new(id: params[:id],
                                              shop_id: current_shop.id)
                                         .run
    flash[:notice] = t('.notice_success')
    redirect_to admin_webhooks_url
  end

  private

  def full_name(user:)
    [user.first_name, user.last_name].map(&:capitalize).join(" ")
  end

end
