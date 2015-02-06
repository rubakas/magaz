class RegistrationsController < ApplicationController
  respond_to :html, :json

  def show
    redirect_to root_url
  end

  def create
    @service = MagazCore::ShopServices::Create.call(shop_params: permitted_params[:shop])
    @shop = @service.shop
    @user = @shop.users.first
    if @shop.persisted?
      session[:user_id] = @user.id
      redirect_to admin_root_url(host: HOSTNAME, subdomain: @shop.subdomain)
    else
      render template: 'welcome/index'
    end
  end

  def validate
    @shop = MagazCore::Shop.new permitted_params[:shop]
    @shop.valid?
    render json: @shop.errors.to_json
  end

  private

  def permitted_params
    { shop:
        params.fetch(:shop, {}).permit(:name, users_attributes: [:first_name, :last_name, :email, :password, :account_owner])}
  end
end
