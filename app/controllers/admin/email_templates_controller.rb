class Admin::EmailTemplatesController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable

  def create
    @shop = current_shop
    @email_template = @shop.email_templates.new(permitted_params[:email_template]) 
  end

  def edit
    @shop = current_shop
    @email_template = @shop.email_templates.find(params[:id])
  end

  def update
    @shop = current_shop
    @email_template = @shop.email_templates.find(params[:id])
    if @email_template.update_attributes(permitted_params[:email_template])
      flash[:notice] = t('.notice')
      redirect_to notifications_settings_admin_settings_path
    else
      render 'edit' 
    end
  end 

  protected

  def permitted_params
    { email_template:
        params.fetch(:email_template, {}).permit(:name, :title, :body) }
  end
end
