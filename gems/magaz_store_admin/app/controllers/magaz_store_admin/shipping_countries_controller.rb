module MagazStoreAdmin
  class ShippingCountriesController < ApplicationController
    include MagazCore::Concerns::Authenticable
    layout 'admin_settings'

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
      @shipping_country = current_shop.shipping_countries.new(permitted_params[:shipping_country])
      country_relation_id = MagazCore::Country.find_by(code: @shipping_country.name).id
      @shipping_country.country_id = country_relation_id
      if @shipping_country.save
        flash[:notice] = t('.notice')
        redirect_to shipping_country_path(@shipping_country)
      else
        render 'new'
      end
    end

    def update
      @shipping_country = current_shop.shipping_countries.find(params[:id])
      @shipping_country.assign_attributes(permitted_params[:shipping_country])

      if @shipping_country.changed?
        country_relation_id = MagazCore::Country.find_by(code: @shipping_country.name).id
        @shipping_country.country_id = country_relation_id
        @shipping_country.save
        flash[:notice] = t('.notice')
        redirect_to shipping_country_path(@shipping_country)
      else
        render 'show'
      end
    end

    def destroy
      @shipping_country = current_shop.shipping_countries.find(params[:id])
      @shipping_country.destroy
      flash[:notice] = t('.notice')
      redirect_to shipping_countries_path
    end

    protected

    def permitted_params
      { shipping_country:
          params.fetch(:shipping_country, {}).permit(:name, :tax, :country_id, :shipping_rates_attributes => [:name, :price_from, :price_to, :weight_from, :weight_to, :shipping_price]) }
    end
  end
end
