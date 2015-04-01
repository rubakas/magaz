module MagazStoreAdmin 
class Admin::UsersController < ApplicationController
  layout 'admin_settings'

  before_action :authenticate?, except: [:show]
  before_action :token_valid?, only: [:show]

  def index
    @users = current_shop.users.page(params[:page])
  end

  def show
    @user = current_shop.users.find(params[:id])
  end

  def new
    @user = current_shop.users.new
  end

  def create
    @service = MagazCore::ShopServices::CreateInvite.call

    if @service.valid_email(email: permitted_params[:user][:email], shop: current_shop)
      @service.create_user_with_email_and_token!(email: permitted_params[:user][:email],
                                               shop: current_shop)
      @service.send_mail_invite(user: @service.user, link: admin_user_url(@service.user, invite_token: @service.user.invite_token ))
      if @service.user.persisted?
        redirect_to admin_users_path, notice: t('.notice')
      else
        redirect_to admin_users_path, notice: t('.invalid_email')
      end
    else
      redirect_to admin_users_path, notice: t('.invalid_email')
    end
  end

  def update
    @user = current_shop.users.find(params[:id])
    if @user.update_attributes(permitted_params[:user])
      redirect_to admin_user_path(@user), notice: t('.notice')
    else
      render 'show'
    end
  end

  def destroy
    @user = current_shop.users.find(params[:id])
    unless @user.account_owner == true || current_shop.users.count == 1
      @user.destroy
      flash[:notice] = t('.notice')
    else
      flash[:notice] = t('.fail')
    end
    redirect_to admin_users_path
  end

  private

  def authenticate?
    unless current_shop.users.exists?(id: session[:user_id])
      redirect_to admin_root_path
    end
  end

  def token_valid?
    if !current_shop.users.exists?(invite_token: params[:invite_token])
      redirect_to admin_root_path, notice: t('.invalid_token')
    end
   end

  protected

  def permitted_params
    { user:
        params.fetch(:user, {}).permit(:first_name, :last_name, :email, :password, permissions:[]) }
  end
end
end
