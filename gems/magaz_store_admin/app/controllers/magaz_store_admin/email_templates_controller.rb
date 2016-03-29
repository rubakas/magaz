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
      service = MagazCore::ShopServices::ChangeEmailTemplate
                  .run(id: @email_template.id, title: params[:email_template][:title],
                       shop_id: current_shop.id, name: params[:email_template][:name],
                       body: params[:email_template][:body],
                       template_type: params[:email_template][:template_type] )
      if service.valid?
        @email_template = service.result
        flash[:notice] = t('.notice_success')
        redirect_to notifications_settings_settings_path
      else
        @email_template = service
        render 'edit'
      end
    end

    protected

    # def permitted_params
    #   { email_template:
    #       params.fetch(:email_template, {}).permit(:name, :title, :body, :template_type) }
    # end
  end
end
