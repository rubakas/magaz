class Admin::CountriesController < ApplicationController
  include MagazCore::Concerns::Authenticable
  layout 'admin_settings'

  def index
    @countries = current_shop.countries.page(params[:page])
  end

  def show
    @country = current_shop.countries.find(params[:id])
  end

  def new
    @country = current_shop.countries.new
  end

  def create
    @country = current_shop.countries.new(permitted_params[:country])
    if @country.save
      flash[:notice] = t('.notice')
      redirect_to admin_country_path(@country)
    else
      render 'new'
    end
  end

  def update
    @country = current_shop.countries.find(params[:id])
    if @country.update_attributes(permitted_params[:country])
      flash[:notice] = t('.notice')
      redirect_to admin_country_path(@country)
    else
      render 'show'
    end
  end

  def destroy
    @country = current_shop.countries.find(params[:id])
    @country.destroy
    flash[:notice] = t('.notice')
    redirect_to admin_shipping_path
  end

  protected

  def permitted_params
    { country:
        params.fetch(:country, {}).permit(:name, :code, :tax, :shipping_rates_attributes => [:name, :price_range, :weight_range, :shipping_price]) }
  end
end
