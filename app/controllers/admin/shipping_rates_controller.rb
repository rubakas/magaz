class Admin::ShippingRatesController < Admin::ApplicationController
  include Concerns::Authenticable
  layout 'admin/admin_settings'

  def index
    @shipping_country = current_shop.shipping_countries.find(params[:shipping_country_id])
    @shipping_rates = @shipping_countries.shipping_rates.page(params[:page])
  end

  def show
    @shipping_country = current_shop.shipping_countries.find(params[:shipping_country_id])
    @shipping_rate = @shipping_country.shipping_rates.find(params[:id])
  end

  def new
    @shipping_country = current_shop.shipping_countries.find(params[:shipping_country_id])
    @shipping_rate = @shipping_country.shipping_rates.new
  end

  def create
    service = AdminServices::ShippingRate::AddShippingRate
              .new(shipping_country_id: params[:shipping_country_id], params: params[:shipping_rate].permit!)
              .run
    @shipping_country = service.result.shipping_country
    @shipping_rate = service.result
    if service.success?
      flash.now[:notice] = t('.notice_success')
      render 'show'
    else
      flash.now[:notice] = t('.notice_fail')
      render 'new'
    end
  end

  def update
    service = AdminServices::ShippingRate::ChangeShippingRate
              .new(id: params[:id], shipping_country_id: params[:shipping_country_id], params: params[:shipping_rate].permit!)
              .run

    @shipping_country = service.shipping_rate.shipping_country
    @shipping_rate = service.result
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_shipping_country_shipping_rate_path
    else
      flash.now[:notice] = t('.notice_fail')
      render 'show'
    end
  end

  def destroy
    service = AdminServices::ShippingRate::DeleteShippingRate
              .new(id: params[:id], shipping_country_id: params[:shipping_country_id])
              .run
    flash[:notice] = t('.notice_success')
    redirect_to admin_shipping_country_path(service.result.shipping_country)
  end

end
