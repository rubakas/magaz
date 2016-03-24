class RegistrationsController < ApplicationController
  respond_to :html, :json

  def show
    redirect_to root_url
  end

  def create
    service = MagazCore::ShopServices::Create.
                run(shop_name: params[:registration][:name], first_name: params[:registration][:first_name],
                    last_name: params[:registration][:last_name], email: params[:registration][:email],
                    password: params[:registration][:password])
    @shop = service.shop
    @user = service.user
    if service.valid?
      session[:user_id] = @user.id
      redirect_to magaz_store_admin.root_url(host: HOSTNAME, subdomain: @shop.subdomain)
    else
      service.errors.full_messages.each do |msg|
       @shop.errors.add(:base, msg)
      end
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
