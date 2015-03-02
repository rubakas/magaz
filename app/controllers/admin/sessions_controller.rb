class Admin::SessionsController < Admin::ApplicationController
  #TODO: layout
  respond_to :html

  def new
  end

  def show
    render :new
  end

  #TODO:  test user not found case
  def create
    @shop = current_shop
    @user = @shop.users.find_by_email(params[:session][:email].downcase)

    if @user && @user.shop_id == @shop.id &&
      (@user.email == params[:session][:email].downcase) &&
       @user.authentic_password?(params[:session][:password])
      # valid login
      session[:user_id] = @user.id
      redirect_to admin_root_url(host: HOSTNAME, subdomain: @shop.subdomain)
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to goodbye_url
  end
end