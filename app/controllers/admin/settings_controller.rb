class Admin::SettingsController < ApplicationController
  include MagazCore::Concerns::Authenticable
  layout 'admin_settings'

  #Settings

  def edit
    @shop = current_shop
  end

  def update
    if current_shop.update_attributes(permitted_params[:shop])
      flash[:notice] = 'Shop was successfully updated.'
      render 'edit'
    else
      render 'edit'
    end
  end

  #Payments

  def payments_settings
    @shop = current_shop
  end

  def payments_settings_update
    if current_shop.update_attributes(permitted_params_for_payments[:shop])
      flash[:notice] = 'Shop was successfully updated.'
      redirect_to payments_settings_admin_settings_path
    else
      render "payments_settings"
    end
  end

  #Checkouts

  def checkouts_settings
    @shop = current_shop
  end

  def checkouts_settings_update
    if current_shop.update_attributes(permitted_params_for_checkouts[:shop])
      flash[:notice] = 'Shop was successfully updated.'
      redirect_to checkouts_settings_admin_settings_path
    else
      render "checkouts_settings"
    end
  end

  #Notifications

  def notifications_settings
    @shop = current_shop
  end

  def notifications_settings_update
    if current_shop.update_attributes(permitted_params_for_notifications[:shop])
      flash[:notice] = 'Shop was successfully updated.'
      redirect_to notifications_settings_admin_settings_path
    else
      render "notifications_settings"
    end
  end

  #Taxes

  def taxes_settings
    @shop = current_shop
  end

  def taxes_settings_update
    if current_shop.update_attributes(permitted_params_for_taxes[:shop])
      flash[:notice] = 'Shop was successfully updated.'
      redirect_to taxes_settings_admin_settings_path
    else
      render "taxes_settings"
    end
  end

  protected

  def permitted_params
    { shop:
        params.fetch(:shop, {}).permit(:name, :address, :business_name,
                                       :city, :country, :currency, :customer_email,
                                       :phone, :province, :timezone, :unit_system,
                                       :zip, :handle, :page_title, :meta_description) }
  end

  def permitted_params_for_checkouts
    { shop:
        params.fetch(:shop, {}).permit(:account_type_choice, :billing_address_is_shipping_too,
                                      :abandoned_checkout_time_delay, :email_marketing_choice,
                                      :after_order_paid, :after_order_fulfilled_and_paid,
                                      :checkout_language, :checkout_refound_policy,
                                      :checkout_privacy_policy, :checkout_term_of_service) }
  end

  def permitted_params_for_payments
    { shop:
      params.fetch(:shop, {}).permit(:authorization_settings)}
  end

  def permitted_params_for_notifications
    { shop:
      params.fetch(:shop, {}).permit()}
  end

    def permitted_params_for_taxes
    { shop:
        params.fetch(:article, {}).permit(:all_taxes_are_included, :charge_taxes_on_shipping_rates) }
  end
end