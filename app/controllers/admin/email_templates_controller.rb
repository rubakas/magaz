class Admin::EmailTemplatesController < Admin::ApplicationController
  include Concerns::Authenticable

  def show
    @email_template = current_shop.email_templates.find(params[:id])
  end

  def edit
    @email_template = current_shop.email_templates.find(params[:id])
  end

  def update
    service = AdminServices::EmailTemplate::ChangeEmailTemplate
              .new( id: params[:id],
                    shop_id: current_shop.id,
                    params: email_template_params)
              .run
    @email_template = service.email_template
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to notifications_settings_admin_settings_path
    else
      flash[:notice] = t('.notice_fail')
      render 'edit'
    end
  end

  private
  
  def email_template_params
    params.require(:email_template).permit(:title, :body)
  end
end
