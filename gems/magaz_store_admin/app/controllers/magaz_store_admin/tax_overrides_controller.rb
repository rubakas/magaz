module MagazStoreAdmin
  class TaxOverridesController < ApplicationController
    layout 'admin_settings'

    def show
      @shipping_country = current_shop.shipping_countries.find_by_id(params[:id])
      @tax_overrides = @shipping_country.tax_overrides.all
    end

    def new
      @collections = current_shop.collections.all
      @shipping_country = current_shop.shipping_countries.find_by_id(params[:shipping_country_id])
      @tax_override = @shipping_country.tax_overrides.new(rate: @shipping_country.tax)
    end

    def create
      service = MagazCore::AdminServices::TaxOverride::AddTaxOverride
                  .run(rate: params[:tax_override][:rate],
                       collection_id: params[:tax_override][:collection_id].to_i,
                       is_shipping: params[:tax_override][:is_shipping],
                       shipping_country_id: params[:shipping_country_id])

      if service.valid?
        @tax_override = service.result
        @shipping_country = @tax_override.shipping_country
        flash[:notice] = t('.notice_success')
        redirect_to tax_override_path(@shipping_country)
      else
        @shipping_country = current_shop.shipping_countries.find_by_id(params[:shipping_country_id])
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
      service = MagazCore::AdminServices::TaxOverride::ChangeTaxOverride
                  .run(id: @tax_override.id,
                       shipping_country_id: params[:tax_override][:shipping_country_id],
                       collection_id: params[:tax_override][:collection_id],
                       rate: params[:tax_override][:rate],
                       is_shipping: params[:tax_override][:is_shipping])
      if service.valid?
        @tax_override = service.result
        @shipping_country = @tax_override.shipping_country
        flash[:notice] = t('.notice_success')
        redirect_to tax_override_path(@shipping_country)
      else
        flash[:notice] = t('.notice_fail')
        redirect_to tax_override_path(@shipping_country)
      end
    end

    def destroy
      service = MagazCore::AdminServices::TaxOverride::DeleteTaxOverride
                  .run(id: params[:id])
      flash[:notice] = t('.notice_success')
      redirect_to tax_override_path(service.shipping_country)
    end

  end
end
