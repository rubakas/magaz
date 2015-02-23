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
    @user = current_shop.users.new(permitted_params[:user])
    @user.invite_token = Digest::SHA1.hexdigest([@user.id, Time.now, rand].join)
    if @user.save(validate: false)
      MagazCore::UserMailer.invite_new_user(@user,
                                            admin_user_url(@user, invite_token: @user.invite_token)).deliver
      redirect_to admin_users_path, notice: t('.notice')
    else
      redirect_to admin_users_path, notice: t('.fails')
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

  def generate_token
    @user = current_shop.users.find(params[:id])
    @user.invite_token = Digest::SHA1.hexdigest([@user.id, Time.now, rand].join)
  end

  protected

  def permitted_params
    { user:
        params.fetch(:user, {}).permit(:first_name, :last_name, :email, :password, permissions:[]) }
  end
end
