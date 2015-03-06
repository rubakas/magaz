class Admin::TaxOverridesController < ApplicationController
  layout 'admin_settings'

  def new
    @collections = current_shop.collections.all
    @shipping_country = current_shop.shipping_countries.find_by_id(params[:country_id])
    @tax_override = @shipping_country.tax_overrides.new
  end

  def create
    @shipping_country = current_shop.shipping_countries.find_by_id(params[:country_id])
    @tax_override = @shipping_country.tax_overrides.new(permitted_params[:tax_override])
    if @tax_override.save
      flash[:notice] = "Nice"
      redirect_to admin_tax_override_path(@shipping_country)
    else
      flash[:notice] = "Not Nice"
      redirect_to admin_tax_override_path(@shipping_country)
    end
  end

  def show
    @shipping_country = current_shop.shipping_countries.find_by_id(params[:id])
  end

  protected

  def permitted_params
    { tax_override:
      params.fetch(:tax_override, {}).permit(:rate, :is_shipping)}
  end
end
