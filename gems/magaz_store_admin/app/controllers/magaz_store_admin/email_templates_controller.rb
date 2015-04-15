module MagazStoreAdmin
  class EmailTemplatesController < ApplicationController
    include MagazCore::Concerns::Authenticable

    def show
      @email_template = current_shop.email_templates.find(params[:id])
    end

    def edit
      @email_template = current_shop.email_templates.find(params[:id])
    end

    def update
      @email_template = current_shop.email_templates.find(params[:id])
      if @email_template.update_attributes(permitted_params[:email_template])
        flash[:notice] = t('.notice_success')
        redirect_to notifications_settings_settings_path
      else
        render 'edit'
      end
    end

    protected

    def permitted_params
      { email_template:
          params.fetch(:email_template, {}).permit(:name, :title, :body, :template_type) }
    end
  end
end
