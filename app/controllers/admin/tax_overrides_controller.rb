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
    if unique?
      if @tax_override.save
        flash[:notice] = t('.success')
        redirect_to admin_tax_override_path(@shipping_country)
      else
        flash[:notice] = t('.fail')
        redirect_to admin_tax_override_path(@shipping_country)
      end
    else
      flash[:notice] = t('.fail')
      redirect_to admin_tax_override_path(@shipping_country)
    end
  end

  def edit
    @tax_override = MagazCore::TaxOverride.find(params[:id])
    @shipping_country = current_shop.shipping_countries.find_by_id(@tax_override.shipping_country_id)
    @collections = current_shop.collections.all
  end

  def update
    @tax_override = MagazCore::TaxOverride.find(params[:id])
    @shipping_country = current_shop.shipping_countries.find_by_id(@tax_override.shipping_country_id)
    if @tax_override.update_attributes(permitted_params[:tax_override])
      flash[:notice] = t('.success')
      redirect_to admin_tax_override_path(@shipping_country)
    else
      flash[:notice] = t('.fail')
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
    flash[:notice] = t('.success')
    redirect_to admin_tax_override_path(@shipping_country)
  end

  private

    def unique?
      shipping_country = current_shop.shipping_countries.find_by_id(params[:shipping_country_id])
      if permitted_params[:tax_override][:is_shipping] == true
        override = shipping_country.tax_overrides.find_by(collection_id: permitted_params[:tax_override][:collection_id])
      else
        override = shipping_country.tax_overrides.find_by(is_shipping: true)
      end
      unless override == nil
        return false
      else
        return true
      end
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
