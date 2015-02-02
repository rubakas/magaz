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
      flash[:notice] = 'User was successfully created.'
      redirect_to admin_user_path(@user)
    else
      render 'show'
    end
  end

  def update
    @user = current_shop.users.find(params[:id])
    if @user.update_attributes(permitted_params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to admin_user_path(@user)
    else
      render 'show'
    end
  end

  def destroy
    @user = current_shop.users.find(params[:id])
    @user.destroy
    flash[:notice] = 'User was successfully deleted.'
    redirect_to admin_users_path
  end

  protected

  def permitted_params
    { user:
        params.fetch(:user, {}).permit(:first_name, :last_name, :email, :password, permissions:[]) }
  end
end
