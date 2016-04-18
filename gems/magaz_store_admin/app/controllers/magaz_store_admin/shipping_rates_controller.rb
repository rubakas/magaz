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
      service = MagazCore::AdminServices::ShippingRate::ChangeShippingRate
                  .run(id: @shipping_rate.id,
                       name: params[:shipping_rate][:name],
                       criteria: params[:shipping_rate][:criteria],
                       price_to: params[:shipping_rate][:price_to],
                       weight_to: params[:shipping_rate][:weight_to],
                       price_from: params[:shipping_rate][:price_from],
                       weight_from: params[:shipping_rate][:weight_from],
                       shipping_price: params[:shipping_rate][:shipping_price])
      if service.valid?
        @shipping_rate = service.result
        flash[:notice] = t('.notice_success')
        redirect_to shipping_country_shipping_rate_path
      else
        flash[:notice] = t('.notice_fails')
        service.errors.full_messages.each do |msg|
          @shipping_rate.errors.add(:base, msg)
        end
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
