class RegistrationsController < ApplicationController
  respond_to :html, :json

  def show
    redirect_to root_path
  end

  def create
    @shop = Shop.new allowed_params
    if @shop.save
      session[:shop_id]=@shop.id
      redirect_to admin_dashboard_path
    else
      render template: 'welcome/index'
    end
  end

  def validate
    @shop = Shop.new allowed_params
    @shop.valid?
    render json: @shop.errors.to_json
  end

  private
  
  def allowed_params
    params.require(:shop).permit(:name,:email,:password)
  end
end
