class RegistrationsController < ApplicationController
  respond_to :html

  inherit_resources
  defaults singleton: true, resource_class: Shop
  actions :create, :new

  def create
    super do |format|
      format.html { redirect_to root_url }
    end
  end
end
