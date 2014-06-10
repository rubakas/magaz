class Admin::SettingsController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  inherit_resources
  defaults :resource_class => MagazCore::Shop, :collection_name => 'shops', :instance_name => 'shop'
  actions :all, :except => [:edit]

  def update
    update! do |success, failure|
      failure.html { render :form }
    end
  end


  protected

  def permitted_params
    { shop:
        params.fetch(:shop, {}).permit(:name, :email, :address, :business_name, :city, :country, :currency, :customer_email,
                                       :phone, :province, :timezone, :unit_system, :zip, :handle, :page_title, :meta_description)}
  end
end
