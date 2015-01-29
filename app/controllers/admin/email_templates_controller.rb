class Admin::EmailTemplatesController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  before_action :get_current_shop

  def show
    @email_template = @shop.email_templates.find(params[:id])
  end

  def create
    @email_template = @shop.email_templates.new(permitted_params[:email_template])
    @email_template.save
  end

  def edit
    @email_template = @shop.email_templates.find(params[:id])
  end

  def update
    @email_template = @shop.email_templates.find(params[:id])
    if @email_template.update_attributes(permitted_params[:email_template])
      flash[:notice] = t('.notice')
      redirect_to notifications_settings_admin_settings_path
    else
      render 'edit'
    end
  end

  protected

  def get_current_shop
    @shop = current_shop
  end

  def permitted_params
    { email_template:
        params.fetch(:email_template, {}).permit(:name, :title, :body, :template_type) }
  end
end
