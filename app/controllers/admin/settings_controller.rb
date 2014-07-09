class Admin::SettingsController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  inherit_resources
  defaults :resource_class => MagazCore::Shop, 
           :collection_name => 'shops', 
           :instance_name => 'shop'
  actions :all, :only => [:edit, :update]

  def update
    update! do |success, failure|
      failure.html { render :form }
      success.html { redirect_to :action => :edit }
    end
  end

  protected

  def resource
    @shop = current_shop.tap do |o|
      logger.info o.inspect
    end

  end

  def permitted_params
    { shop:
        params.fetch(:shop, {}).permit(:name, :email, :address, :business_name, 
                                       :city, :country, :currency, :customer_email,
                                       :phone, :province, :timezone, :unit_system, 
                                       :zip, :handle, :page_title, :meta_description) }
  end
end
