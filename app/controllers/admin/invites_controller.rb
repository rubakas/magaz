class Admin::InvitesController < ApplicationController
  include MagazCore::Concerns::Authenticable
  layout 'admin_settings'

  def new
    @invite = current_shop.invites.new
  end

  def create
    @invite = current_shop.invites.new(permitted_params[:invite])
    @invite.sender_id = current_user.id
    if @invite.save
      MagazCore::UserMailer.invite_new_user(@invite,
                                              new_admin_user_url(invite_token: @invite.token)).deliver
      flash[:notice] = t('.new_notice_success')
      redirect_to admin_users_path
    else
      flash[:notice] = t('.new_notice_fail')
      redirect_to admin_users_path
    end
  end

  def destroy
    @invite = MagazCore::Invite.find_by_id(params[:id])
    @invite.destroy
    redirect_to root_path
  end

  protected

  def permitted_params
    { invite:
        params.fetch(:invite, {}).permit(:email)}
  end
end
