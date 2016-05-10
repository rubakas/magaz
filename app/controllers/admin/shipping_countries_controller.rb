class Admin::ShippingCountriesController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
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
    service = MagazCore::AdminServices::ShippingCountry::AddShippingCountry
                .run(shop_id: current_shop.id,
                     tax: params[:shipping_country][:tax],
                     name: params[:shipping_country][:name])
    if service.valid?
      @shipping_country = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_shipping_country_path(@shipping_country)
    else
      @shipping_country = service.shipping_country
      flash.now[:notice] = t('.notice_fail')
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
      redirect_to admin_shipping_country_path(@shipping_country)
    else
      @shipping_country = service.shipping_country
      flash.now[:notice] = t('.notice_fail')
      render 'show'
    end
  end

  def destroy
    service = MagazCore::AdminServices::ShippingCountry::DeleteShippingCountry
                .run(id: params[:id],
                     shop_id: current_shop.id)
    flash[:notice] = t('.notice_success')
    redirect_to admin_shipping_countries_path
  end

end
