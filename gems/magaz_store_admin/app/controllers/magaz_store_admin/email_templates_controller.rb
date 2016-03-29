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
      service = MagazCore::ShopServices::ChangeEmailTemplate.run(id: @email_template.id, 
                title: params[:product][:title], shop_id: current_shop.id,
                name: params[:product][:name], body: params[:product][:body],
                template_type: params[:product][:template_type] )
      if service.valid?
        @email_template = service.result
        flash[:notice] = t('.notice_success')
        redirect_to notifications_settings_settings_path
      else
        service.errors.full_messages.each do |msg|
          @email_template.errors.add(:base, msg)
        end
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
