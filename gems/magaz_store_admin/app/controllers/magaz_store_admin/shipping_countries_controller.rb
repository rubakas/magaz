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
      service = MagazCore::AdminServices::ShippingCountry::AddShippingCountry
                  .run(shop_id: current_shop.id,
                       tax: params[:shipping_country][:tax],
                       name: params[:shipping_country][:name])
      if service.valid?
        @shipping_country = service.result
        flash[:notice] = t('.notice_success')
        redirect_to shipping_country_path(@shipping_country)
      else
        @shipping_country = MagazCore::ShippingCountry.new
        service.errors.full_messages.each do |msg|
          @shipping_country.errors.add(:base, msg)
        end
        render 'new'
      end
    end

    def update
      service = MagazCore::AdminServices::ShippingCountry::ChangeShippingCountry
                  .run(id: params[:id],
                       shop_id: current_shop.id,
                       tax: params[:shipping_country][:tax],
                       name: params[:shipping_country][:name])
      if service.valid?
        @shipping_country = service.result
        flash[:notice] = t('.notice_success')
        redirect_to shipping_country_path(@shipping_country)
      else
        @shipping_country = current_shop.shipping_countries.find(params[:id])
        service.errors.full_messages.each do |msg|
          @shipping_country.errors.add(:base, msg)
        end
        render 'show'
      end
    end

    def destroy
      service = MagazCore::AdminServices::ShippingCountry::DeleteShippingCountry
                  .run(id: params[:id],
                       shop_id: current_shop.id)
      flash[:notice] = t('.notice_success')
      redirect_to shipping_countries_path
    end
    
  end
end
