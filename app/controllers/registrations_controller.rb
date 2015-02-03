class RegistrationsController < ApplicationController
  respond_to :html, :json

  def show
    redirect_to root_url
  end

  def create
    @service = MagazCore::ShopServices::Create.call(shop_params: permitted_params)
    @shop = @service.shop
    user_first_name = params[:first_name]
    user_last_name = params[:last_name]
    if @shop.persisted?
      @service2 = MagazCore::ShopServices::CreateUser.call(shop_id: @shop.id,
                                                           params: permitted_params)
      session[:user_id] = @shop.id
      redirect_to admin_root_url(host: HOSTNAME, subdomain: @shop.subdomain)
    else
      render template: 'welcome/index'
    end
  end

  def validate
    @shop = MagazCore::Shop.new permitted_params
    @shop.valid?
    render json: @shop.errors.to_json
  end

  private

  def permitted_params
    { shop:
        params.fetch(:shop, {}).permit(:name, :email, :password, users_attributes: [:first_name, :last_name])}
  end
end
