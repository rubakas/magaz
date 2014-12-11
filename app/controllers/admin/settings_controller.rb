class Admin::SettingsController < ApplicationController
  include MagazCore::Concerns::Authenticable
  layout 'admin_settings'

  def edit
    @shop = current_shop
  end

  def update
    @shop = current_shop
    if @shop.update_attributes(permitted_params[:shop])
      flash[:notice] = 'Shop was successfully updated.'
      render 'edit'
    else
      render 'edit'
    end
  end

  protected

  def resource
    @shop = current_shop
  end

  def permitted_params
    { shop:
        params.fetch(:shop, {}).permit(:name, :email, :address, :business_name,
                                       :city, :country, :currency, :customer_email,
                                       :phone, :province, :timezone, :unit_system,
                                       :zip, :handle, :page_title, :meta_description) }
  end
end
