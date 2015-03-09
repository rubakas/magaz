class Admin::TaxOverridesController < ApplicationController
  layout 'admin_settings'

  def new
    @collections = current_shop.collections.all
    @shipping_country = current_shop.shipping_countries.find_by_id(params[:shipping_country_id])
    @tax_override = @shipping_country.tax_overrides.new(rate: @shipping_country.tax)
  end

  def create
    @shipping_country = current_shop.shipping_countries.find_by_id(params[:shipping_country_id])
    @tax_override = @shipping_country.tax_overrides.new(permitted_params[:tax_override])
    unless params[:tax_override][:is_shipping] == false && params[:collection_id] == nil
      if @tax_override.save
        flash[:notice] = "Nice"
        redirect_to admin_tax_override_path(@shipping_country)
      else
        flash[:notice] = "Not Nice"
        redirect_to admin_tax_override_path(@shipping_country)
      end
    else
      flash[:notice] = "Wrong and Not Nice"
      redirect_to admin_tax_override_path(@shipping_country)
    end
  end

  def show
    @shipping_country = current_shop.shipping_countries.find_by_id(params[:id])
    @tax_overrides = @shipping_country.tax_overrides.all
  end

  def destroy
    @tax_override = MagazCore::TaxOverride.find(params[:id])
    @shipping_country = current_shop.shipping_countries.find_by_id(@tax_override.shipping_country_id)
    @tax_override.destroy
    redirect_to admin_tax_override_path(@shipping_country)
  end

  protected

  def permitted_params
    { tax_override:
      params.fetch(:tax_override, {}).permit(:rate,
                                             :is_shipping,
                                             :collection_id,
                                             :shipping_country_id)}
  end
end
