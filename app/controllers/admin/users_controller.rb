class Admin::UsersController < Admin::ApplicationController
  layout 'admin/admin_settings'

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
    url_building_proc = lambda {|user_object|
                                admin_user_url(user_object,
                                               invite_token: user_object.invite_token)}

    service = AdminServices::Invite::CreateInvite
              .run(url_building_proc: url_building_proc,
                   email: params[:user][:email],
                   shop_id: current_shop.id)

    if service.valid?
      redirect_to admin_users_path, notice: t('.notice_success')
    else
      redirect_to admin_users_path, notice: t('.invalid_email')
    end
  end

  def update
    @current_user = current_shop.users.find(session[:user_id])
    service =  AdminServices::User::ChangeUser
               .new(id: params[:id],
                    shop_id: current_shop.id,
                    params: params[:user].permit!)
               .run
    @user = service.result
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_user_path(@user)
    else
      flash[:notice] = t('.notice_fail')
      render 'show'
    end
  end

  def destroy
    service = AdminServices::User::DeleteUser
              .new(id: params[:id])
              .run
    if service.success?
      flash[:notice] = t('.notice_success')
    else
      flash[:notice] = service.result.errors.full_messages.first
    end
    redirect_to admin_users_path
  end

  def authenticate?
    unless current_shop.users.exists?(id: session[:user_id])
      redirect_to admin_index_path
    end
  end

  def token_valid?
    if !current_shop.users.exists?(invite_token: params[:invite_token])
      redirect_to admin_index_path, notice: t('.invalid_token')
    end
   end

 protected

  def permitted_params
    { user:
        params.fetch(:user, {}).permit(:first_name, :last_name, :email, :password, permissions:[]) }
  end
end
