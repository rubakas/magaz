class Admin::UsersController < ApplicationController
  include MagazCore::Concerns::Authenticable
  layout 'admin_settings'

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
    @user.destroy
    redirect_to admin_users_path, notice: t('.notice')
  end

  protected

  def permitted_params
    { user:
        params.fetch(:user, {}).permit(:first_name, :last_name, :email, :password, permissions:[]) }
  end
end
