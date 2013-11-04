class Admin::SessionsController < ApplicationController
  respond_to :html

  def new
  end

  def show
    render :new
  end

  #TODO test user not found case
  def create
    @shop = current_shop

    if @shop && 
      (@shop.email == params[:session][:email].downcase) && 
      @shop.authentic_password?(params[:session][:password])
      # valid login
      session[:user_id] = @shop.id
      redirect_to admin_root_url(host: HOSTNAME_SHOP, subdomain: @shop.subdomain)
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
    session[:user_id] = nil
    redirect_to goodbye_url
  end
end