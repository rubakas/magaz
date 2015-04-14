module MagazStoreAdmin
  class TaxOverridesController < ApplicationController
    layout 'admin_settings'

    def new
      @collections = current_shop.collections.all
      @shipping_country = current_shop.shipping_countries.find_by_id(params[:shipping_country_id])
      @tax_override = @shipping_country.tax_overrides.new(rate: @shipping_country.tax)
    end

    def create
      @service = MagazCore::ShopServices::CreateTaxOverride.call(params: permitted_params[:tax_override],
                                                                 shipping_country_id: params[:shipping_country_id])
      @tax_override = @service.tax_override
      @shipping_country = current_shop.shipping_countries.find_by_id(params[:shipping_country_id])
      if @tax_override.persisted?
        flash[:notice] = t('.notice_success')
        redirect_to tax_override_path(@shipping_country)
      else
        flash[:notice] = t('.notice_fail')
        redirect_to tax_override_path(@shipping_country)
      end
    end

    def edit
      @tax_override = MagazCore::TaxOverride.find(params[:id])
      @shipping_country = @tax_override.shipping_country
      @collections = current_shop.collections.all
    end

    def update
      @tax_override = MagazCore::TaxOverride.find(params[:id])
      @shipping_country = @tax_override.shipping_country
      if @tax_override.update_attributes(permitted_params[:tax_override])
        flash[:notice] = t('.notice_success')
        redirect_to tax_override_path(@shipping_country)
      else
        flash[:notice] = t('.notice_fail')
        redirect_to tax_override_path(@shipping_country)
      end
    end

    def show
      @shipping_country = current_shop.shipping_countries.find_by_id(params[:id])
      @tax_overrides = @shipping_country.tax_overrides.all
    end

    def destroy
      @tax_override = MagazCore::TaxOverride.find(params[:id])
      @shipping_country = @tax_override.shipping_country
      @tax_override.destroy
      flash[:notice] = t('.notice_success')
      redirect_to tax_override_path(@shipping_country)
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
end
