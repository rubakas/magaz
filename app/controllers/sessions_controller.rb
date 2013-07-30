class SessionsController < ApplicationController
  respond_to :html, :json

  def new
  end

  def show
    render :new
  end

  #TODO test user not found case
  def create
    @shop = Shop.find_by_email(params[:session][:email])

    if @shop && @shop.authentic_password?(params[:session][:password])
      session[:shop_id] = @shop.id
      redirect_to admin_dashboard_path
    else
      if @shop
        flash[:alert] = I18n.t('sessions.create.wrong_password')
      else
        flash[:alert] = I18n.t('sessions.create.user_not_found')
      end
      flash.discard(:alert)
      render :new
    end
  end

  def destroy
    session[:shop_id] = nil
    redirect_to root_url
  end
end