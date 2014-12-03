class Admin::UsersController < ApplicationController
  include MagazCore::Concerns::Authenticable
  #inherit_resources
  layout 'admin_settings'
  #actions :all, :except => [:edit]

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
      flsh[:notice] = 'User was successfully updated.'
      redirect_to admin_user_path(@user)
    else
      render 'show'
    end
  end

  def destroy
    @user = current_shop.users.find(params[:id])
    @user.destroy
    flash[:notice] = 'User was successfully deleted.'
    render 'index'
  end

  protected

  def begin_of_association_chain
    current_shop
  end

  def collection
    @users ||= end_of_association_chain.page(params[:page])
  end

  def resource
    @user ||= end_of_association_chain.find(params[:id])
  end

  def permitted_params
    { user:
        params.fetch(:user, {}).permit(:first_name, :last_name, :email, permissions:[]) }
  end
end
