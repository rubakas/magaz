class RegistrationsController < ApplicationController
  respond_to :html

  def create
    @shop = Shop.new allowed_params
    if @shop.save
      session[:shop_id]=@shop.id
      redirect_to admin_dashboard_path
    else
      render template: 'welcome/index'
    end
  end

  private
  
  def allowed_params
    params.require(:shop).permit(:name,:email,:password)
  end
end
