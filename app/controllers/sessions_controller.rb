class SessionsController < ApplicationController
  respond_to :html

  def new
  end

  def show
    render :new
  end

  #TODO:  test user not found case
  def create
    @shop = MagazCore::Shop.find_by(subdomain: params[:session][:subdomain])
    @user = MagazCore::User.find_by_email(params[:session][:email])

    if(@shop && @user.authentic_password?(params[:session][:password]) &&
      !@shop.users.find_by(id: @user.id) == nil)
      session[:user_id] = @user.id
      redirect_to admin_root_url(host: HOSTNAME, subdomain: @shop.subdomain)
    elsif
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