class Admin::TaxOverridesController < Admin::ApplicationController
  layout 'admin/admin_settings'

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
    service = AdminServices::TaxOverride::AddTaxOverride
              .new(shipping_country_id: params[:shipping_country_id], params: params[:tax_override].permit!)
              .run
    @tax_override = service.result
    @shipping_country = @tax_override.shipping_country
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_tax_override_path(@shipping_country)
    else
      flash[:notice] = t('.notice_fail')
      redirect_to admin_tax_override_path(@shipping_country)
    end
  end

  def edit
    @tax_override = TaxOverride.find(params[:id])
    @shipping_country = @tax_override.shipping_country
    @collections = current_shop.collections.all
  end

  def update
    service = AdminServices::TaxOverride::ChangeTaxOverride
              .new(id: params[:id],
                   shipping_country_id: params[:shipping_country_id],
                   params: params[:tax_override].permit!)
              .run
    @tax_override = service.result
    @shipping_country = @tax_override.shipping_country
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_tax_override_path(@shipping_country)
    else
      flash[:notice] = t('.notice_fail')
      redirect_to admin_tax_override_path(@shipping_country)
    end
  end

  def destroy
    service = AdminServices::TaxOverride::DeleteTaxOverride
              .new(id: params[:id])
              .run
    flash[:notice] = t('.notice_success')
    redirect_to admin_tax_override_path(service.result.shipping_country)
  end

end
