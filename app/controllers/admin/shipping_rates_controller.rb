class Admin::ShippingRatesController < ApplicationController
  include MagazCore::Concerns::Authenticable
  layout 'admin_settings'

  def index
    @country = current_shop.countries.find(params[:country_id])
    @shipping_rates = @countries.shipping_rates.page(params[:page])
  end

  def show
    @country = current_shop.countries.find(params[:country_id])
    @shipping_rate = @country.shipping_rates.find(params[:id])
  end

  def new
    @country = current_shop.countries.find(params[:country_id])
    @shipping_rate = @country.shipping_rates.new
  end

  def create
    @country = current_shop.countries.find(params[:country_id])
    @shipping_rate = @country.shipping_rates.new(permitted_params[:shipping_rate])
    if @shipping_rate.save
      flash[:notice] = t('.notice')
      render 'show'
    else
      render 'new'
    end
  end

  def update
    @country = current_shop.countries.find(params[:country_id])
    @shipping_rate = @country.shipping_rates.find(params[:id])
    if @shipping_rate.update_attributes(permitted_params[:shipping_rate])
      flash[:notice] = t('.notice')
      redirect_to admin_country_shipping_rate_path
    else
      render 'show'
    end
  end

  def destroy
    @country = current_shop.countries.find(params[:country_id])
    @shipping_rate = @country.shipping_rates.find(params[:id])
    @shipping_rate.destroy
    flash[:notice] = t('.notice')
    redirect_to admin_country_path(@country)
  end

  protected

  def permitted_params
    { shipping_rate:
        params.fetch(:shipping_rate, {}).permit(:name, :criteria, :price_from, :price_to, :weight_from, :weight_to, :shipping_price) }
  end
end
