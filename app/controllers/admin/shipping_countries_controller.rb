class Admin::ShippingCountriesController < Admin::ApplicationController
  include Concerns::Authenticable
  layout 'admin/admin_settings'

  def index
    @shipping_countries = current_shop.shipping_countries.page(params[:page])
  end

  def show
    @shipping_country = current_shop.shipping_countries.find(params[:id])
  end

  def new
    @shipping_country = current_shop.shipping_countries.new
  end

  def create
    service = AdminServices::ShippingCountry::AddShippingCountry
              .new(shop_id: current_shop.id, params: params[:shipping_country].permit!)
              .run
    @shipping_country = service.result
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_shipping_country_path(@shipping_country)
    else
      flash.now[:notice] = t('.notice_fail')
      render 'new'
    end
  end

  def update
    service = AdminServices::ShippingCountry::ChangeShippingCountry
              .new(id: params[:id], shop_id: current_shop.id, params: params[:shipping_country].permit!)
              .run
    @shipping_country = service.result
    if service.valid?
      flash[:notice] = t('.notice_success')
      redirect_to admin_shipping_country_path(@shipping_country)
    else
      flash.now[:notice] = t('.notice_fail')
      render 'show'
    end
  end

  def destroy
    AdminServices::ShippingCountry::DeleteShippingCountry
    .new(id: params[:id], shop_id: current_shop.id)
    .run
    flash[:notice] = t('.notice_success')
    redirect_to admin_shipping_countries_path
  end

end
