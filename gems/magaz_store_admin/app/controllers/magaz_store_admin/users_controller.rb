module MagazStoreAdmin
  class UsersController < ApplicationController
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
      @current_user = current_shop.users.find(session[:user_id])
      @service = MagazCore::AdminServices::Invite::CreateInvite.call

      if @service.valid_email(email: permitted_params[:user][:email], shop: current_shop)
        @service.create_user_with_email_and_token!(email: permitted_params[:user][:email],
                                                 shop: current_shop)
        @service.send_mail_invite(user: @service.user, link: user_url(@service.user, invite_token: @service.user.invite_token ))
        if @service.user.persisted?
          redirect_to users_path, notice: t('.notice_success')
        else
          redirect_to users_path, notice: t('.invalid_email')
        end
      else
        redirect_to users_path, notice: t('.invalid_email')
      end
    end

    def update
      puts params[:user][:permissions].inspect
      @user = current_shop.users.find(params[:id])
      @current_user = current_shop.users.find(session[:user_id])
      service = MagazCore::AdminServices::User::ChangeUser
                 .run(id: @user.id,
                      first_name: params[:user][:first_name],
                      last_name: params[:user][:last_name],
                      email: params[:user][:email],
                      password: params[:user][:password],
                      permissions: params[:user][:permissions])
      if service.valid?
        @user = service.result
        flash[:notice] = t('.notice_success')
        redirect_to user_path(@user)
      else
        flash[:notice] = t('.notice_fail')
        service.errors.full_messages.each do |msg|
          @user.errors.add(:base, msg)
        end
        render 'show'
      end
    end

    def destroy
      @user = current_shop.users.find(params[:id])
      @current_user = current_shop.users.find(session[:user_id])
      unless @user.account_owner == true || current_shop.users.count == 1
        @user.destroy
        flash[:notice] = t('.notice_success')
      else
        flash[:notice] = t('.notice_fail')
      end
      redirect_to users_path
    end

    def authenticate?
      unless current_shop.users.exists?(id: session[:user_id])
        redirect_to root_path
      end
    end

    def token_valid?
      if !current_shop.users.exists?(invite_token: params[:invite_token])
        redirect_to root_path, notice: t('.invalid_token')
      end
     end

    protected

    def permitted_params
      { user:
          params.fetch(:user, {}).permit(:first_name, :last_name, :email, :password, permissions:[]) }
    end
  end
end
