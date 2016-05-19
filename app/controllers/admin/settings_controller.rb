class Admin::SettingsController < Admin::ApplicationController
  include Concerns::Authenticable
  layout 'admin/admin_settings'

  #Settings

  def edit
    @shop = current_shop
  end

  def update
    service = AdminServices::Shop::ChangeShop
                .run(id: current_shop.id,
                     name: params[:shop][:name],
                     business_name: params[:shop][:business_name],
                     city: params[:shop][:city],
                     country: params[:shop][:country],
                     currency: params[:shop][:currency],
                     customer_email: params[:shop][:customer_email],
                     phone: params[:shop][:phone],
                     timezone: params[:shop][:timezone] ,
                     unit_system: params[:shop][:unit_system],
                     zip: params[:shop][:zip],
                     page_title: params[:shop][:page_title],
                     meta_description: params[:shop][:meta_description],
                     address: params[:shop][:address])
    if service.valid?
      @shop = service.result
      # @webhook_service = AdminServices::EventWebhookRunner.call(event: @event_service.event,
      #                                                                     topic: Webhook::Topics::UPDATE_SHOP_EVENT)
      flash.now[:notice] = I18n.t('admin.settings.notice_success')
      render 'edit'
    else
      @shop = service.shop
      render 'edit'
    end
  end

  #Payments

  def payments_settings
    @shop = current_shop
  end

  def payments_settings_update
    service = AdminServices::Shop::ChangePaymentSettings
                .run(id: current_shop.id,
                     authorization_settings: params[:shop][:authorization_settings])
    @shop = service.result
    if service.valid?
      flash[:notice] = I18n.t('admin.settings.notice_success')
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
    service = AdminServices::Shop::ChangeCheckoutSettings
                .run(id: current_shop.id,
                     account_type_choice: params[:shop][:account_type_choice],
                     enable_multipass_login: params[:shop][:enable_multipass_login],
                     billing_address_is_shipping_too: params[:shop][:billing_address_is_shipping_too],
                     abandoned_checkout_time_delay: params[:shop][:abandoned_checkout_time_delay],
                     email_marketing_choice: params[:shop][:email_marketing_choice],
                     after_order_paid: params[:shop][:after_order_paid],
                     notify_customers_of_their_shipment: params[:shop][:notify_customers_of_their_shipment],
                     automatically_fulfill_all_orders: params[:shop][:automatically_fulfill_all_orders],
                     after_order_fulfilled_and_paid: params[:shop][:after_order_fulfilled_and_paid],
                     checkout_refund_policy: params[:shop][:checkout_refund_policy],
                     checkout_privacy_policy: params[:shop][:checkout_privacy_policy],
                     checkout_term_of_service: params[:shop][:checkout_term_of_service])

    if service.valid?
      @shop = service.result
      flash[:notice] = I18n.t('admin.settings.notice_success')
      redirect_to checkouts_settings_admin_settings_path
    else
      @shop = service.shop
      render "checkouts_settings"
    end
  end

  #Notifications

  def notifications_settings
    @shop = current_shop
  end

  #Taxes

  DIGITAL_GOODS_VAT_TAX = "Digital Goods VAT Tax"

  def taxes_settings
    @shop = current_shop
    if @shop.eu_digital_goods_collection_id == nil
      @default_collection = @shop.collections.find_by(name: DIGITAL_GOODS_VAT_TAX)
    else
      @default_collection = @shop.eu_digital_goods_collection
    end
  end

  def taxes_settings_update
    service = AdminServices::Shop::ChangeTaxesSettings
                .run(id: current_shop.id,
                     all_taxes_are_included: params[:shop][:all_taxes_are_included],
                     charge_taxes_on_shipping_rates: params[:shop][:charge_taxes_on_shipping_rates],
                     charge_vat_taxes: params[:charge_vat_taxes])
    if service.valid?
      @shop = service.result
      flash[:notice] = I18n.t('admin.settings.notice_success')
      redirect_to taxes_settings_admin_settings_path
    else
      @shop = service.shop
      render "taxes_settings"
    end
  end

  def enable_eu_digital_goods_vat_taxes
    service = AdminServices::Shop::EnableEuDigitalGoods
                .run(id: current_shop.id,
                     collection_name: DIGITAL_GOODS_VAT_TAX)
    if service.valid?
      flash.now[:notice] = I18n.t('admin.settings.notice_success')
      redirect_to taxes_settings_admin_settings_path
    else
      flash.now[:notice] = service.errors.full_messages.first
      redirect_to taxes_settings_admin_settings_path
    end
  end

  def set_default_collection
    @shop = current_shop
    @default_collection = current_shop.eu_digital_goods_collection
    @collections = current_shop.collections.page(params[:page])
  end

  def save_default_collection
    service = AdminServices::Shop::ChangeDefaultCollection
                .run(id: current_shop.id, collection_id: params[:default_collection])
    unless service.valid?
      flash.now[:notice] = service.errors.full_messages.first
    end
    redirect_to taxes_settings_admin_settings_path
  end

end
