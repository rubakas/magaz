class Admin::ShippingRatesController < ApplicationController
  include MagazCore::Concerns::Authenticable
  layout 'admin_settings'

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
    service = MagazCore::AdminServices::ShippingRate::AddShippingRate
                .run(name: params[:shipping_rate][:name],
                     criteria: params[:shipping_rate][:criteria],
                     price_to: params[:shipping_rate][:price_to],
                     weight_to: params[:shipping_rate][:weight_to],
                     price_from: params[:shipping_rate][:price_from],
                     weight_from: params[:shipping_rate][:weight_from],
                     shipping_country_id: params[:shipping_country_id],
                     shipping_price: params[:shipping_rate][:shipping_price])
    @shipping_country = service.shipping_rate.shipping_country
    if service.valid?
      @shipping_rate = service.result
      flash.now[:notice] = t('.notice_success')
      render 'show'
    else
      @shipping_rate = service.shipping_rate
      flash.now[:notice] = t('.notice_fail')
      render 'new'
    end
  end

  def update
    service = MagazCore::AdminServices::ShippingRate::ChangeShippingRate
                .run(id: params[:id],
                     name: params[:shipping_rate][:name],
                     criteria: params[:shipping_rate][:criteria],
                     price_to: params[:shipping_rate][:price_to],
                     weight_to: params[:shipping_rate][:weight_to],
                     price_from: params[:shipping_rate][:price_from],
                     shipping_country_id: params[:shipping_country_id],
                     weight_from: params[:shipping_rate][:weight_from],
                     shipping_price: params[:shipping_rate][:shipping_price])
    @shipping_country = service.shipping_rate.shipping_country
    if service.valid?
      @shipping_rate = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_shipping_country_shipping_rate_path
    else
      @shipping_rate = service.shipping_rate
      flash.now[:notice] = t('.notice_fail')
      render 'show'
    end
  end

  def destroy
    service = MagazCore::AdminServices::ShippingRate::DeleteShippingRate
                .run(id: params[:id],
                     shipping_country_id: params[:shipping_country_id])
    flash[:notice] = t('.notice_success')
    redirect_to admin_shipping_country_path(service.shipping_country)
  end

end
