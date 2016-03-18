class RegistrationsController < ApplicationController
  respond_to :html, :json

  def show
    redirect_to root_url
  end

  def create
    @service = MagazCore::ShopServices::Create.call(shop_params: permitted_params_for_shop[:shop],
                                                    user_params: permitted_params_for_user[:user])
    @shop = @service.shop
    @user = @service.user
    if @shop.persisted?
      session[:user_id] = @user.id
      cookies[:session] = { domain: @shop.subdomain }
      redirect_to magaz_store_admin.root_url(host: HOSTNAME, subdomain: @shop.subdomain)
    else
      render template: 'welcome/index'
    end
  end

  def validate
    @shop = MagazCore::Shop.new permitted_params_for_shop[:shop]
    @shop.valid?
    render json: @shop.errors.to_json
  end

  private

  def permitted_params_for_user
    { user:
        params.fetch(:registration, {}).permit(:first_name, :last_name, :email, :password)}
  end

  def permitted_params_for_shop
    { shop:
        params.fetch(:registration, {}).permit(:name)}
  end
end
