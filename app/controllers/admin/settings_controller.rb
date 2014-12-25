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

  def payments_settings
    @shop = current_shop
    render 'payments_settings'
  end

  def payments_settings_update
    @shop = current_shop
    if @shop.update_attributes(permitted_params_for_payments[:shop])
      flash[:notice] = 'Shop was successfully updated.'
      redirect_to payments_settings_admin_settings_path 
    else 
      flash[:notice] = 'Try again.'
      render "payments_settings"
    end
  end

  def checkouts_settings
    @shop = current_shop
    render 'checkouts_settings'
  end

  def checkouts_settings_update
    @shop = current_shop
    if @shop.update_attributes(permitted_params_for_checkouts[:shop])
      flash[:notice] = 'Shop was successfully updated.'
      redirect_to checkouts_settings_admin_settings_path 
    else 
      flash[:notice] = 'Try again.'
      render "checkouts_settings"
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

  def permitted_params_for_checkouts
    { shop:
        params.fetch(:shop, {}).permit(:account_type_choice,:bulling_adress_is_shipping_too,
                                      :abandoned_checkout_time_delay,:email_marketing_choice,
                                      :after_order_paid,:after_order_fulfilled_and_paid,
                                      :checkout_language,:checkout_refound_policy,
                                      :checkout_privacy_policy, :checkout_term_of_service) }
  end
  
  def permitted_params_for_payments
    {
      shop:
      params.fetch(:shop, {}).permit(:authoriz_settings)}
  end
end