module MagazStoreAdmin
  class ShippingRatesController < ApplicationController
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
      @shipping_country = current_shop.shipping_countries.find(params[:shipping_country_id])
      @shipping_rate = @shipping_country.shipping_rates.new(permitted_params[:shipping_rate])
      if @shipping_rate.save
        flash[:notice] = t('.notice_success')
        render 'show'
      else
        render 'new'
      end
    end

    def update
      @shipping_country = current_shop.shipping_countries.find(params[:shipping_country_id])
      @shipping_rate = @shipping_country.shipping_rates.find(params[:id])
      if @shipping_rate.update_attributes(permitted_params[:shipping_rate])
        flash[:notice] = t('.notice_success')
        redirect_to shipping_country_shipping_rate_path
      else
        render 'show'
      end
    end

    def destroy
      @shipping_country = current_shop.shipping_countries.find(params[:shipping_country_id])
      @shipping_rate = @shipping_country.shipping_rates.find(params[:id])
      @shipping_rate.destroy
      flash[:notice] = t('.notice_success')
      redirect_to shipping_country_path(@shipping_country)
    end

    protected

    def permitted_params
      { shipping_rate:
          params.fetch(:shipping_rate, {}).permit(:name, :criteria, :price_from, :price_to, :weight_from, :weight_to, :shipping_price) }
    end
  end
end
