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
    @user = MagazCore::User.find_by_email(params[:session][:email])

    if @shop &&
      (@user.email == params[:session][:email].downcase) &&
      @user.authentic_password?(params[:session][:password])
      # valid login
      session[:user_id] = @user.id
      redirect_to admin_root_url(host: HOSTNAME, subdomain: @shop.subdomain)
    else
      if @shop
        flash[:alert] = I18n.t('sessions.create.wrong_password')
      else
        flash[:alert] = I18n.t('sessions.create.user_not_found')
      end
      flash.discard(:alert) #FIXME: WTF is this?
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to goodbye_url
  end
end