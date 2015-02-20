class Admin::UsersController < ApplicationController
  layout 'admin_settings'

  before_action :authenticate?, except: [:new]
  before_action :token_valid?, only: [:new]

  def index
    @users = current_shop.users.page(params[:page])
  end

  def show
    @user = current_shop.users.find(params[:id])
  end

  def new
    @user = current_shop.users.new
    @invite = MagazCore::Invite.find_by(token: params[:invite_token])
  end

  def create
    @user = current_shop.users.new(permitted_params[:user])
    if @user.save
      redirect_to admin_user_path(@user), notice: t('.notice')
    else
      render 'show'
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
    if !@user.account_owner == true
      @user.destroy
      flash[:notice] = t('.notice')
    else
      flash[:notice] = t('.error')
    end
    redirect_to admin_users_path
  end

  private

  def authenticate?
    if !current_shop.invites.exists?(token: params[:invite_token]) && !current_shop.users.exists?(id: session[:user_id])
      flash[:notice] = t('.invalid_token')
      redirect_to admin_root_path
    end
  end

  def token_valid?
    if !current_shop.invites.exists?(token: params[:invite_token]) && current_shop.users.exists?(id: session[:user_id])
      redirect_to admin_root_path
    end
  end

  protected

  def permitted_params
    { user:
        params.fetch(:user, {}).permit(:first_name, :last_name, :email, :password, permissions:[]) }
  end
end
