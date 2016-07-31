class RegistrationsController < ApplicationController
  respond_to :html, :json

  def show
    redirect_to root_url
  end

  def create
    @create_service = StoreServices::Create
              .new(params: params[:registration].permit!)
              .run
    @shop = @create_service.result[:shop]
    if @create_service.success?
      @user = @create_service.result[:user]
      session[:user_id] = @user.id
      redirect_to admin_index_url(host: HOSTNAME, subdomain: @shop.subdomain)
    else
      render template: 'welcome/index'
    end
  end

  def validate
    @shop = Shop.new permitted_params_for_shop[:shop]
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
