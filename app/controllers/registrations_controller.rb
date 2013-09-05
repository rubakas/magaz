class RegistrationsController < ApplicationController
  respond_to :html, :json

  def show
    redirect_to root_url
  end

  def create
    @shop = Shop.new permitted_params
    if @shop.save
      session[:shop_id]=@shop.id
      redirect_to admin_root_url
    else
      render template: 'welcome/index'
    end
  end

  def validate
    @shop = Shop.new permitted_params
    @shop.valid?
    render json: @shop.errors.to_json
  end

  private
  
  def permitted_params
    params.require(:shop).permit(:name,:email,:password)
  end
end
