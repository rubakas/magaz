class Admin::TaxOverridesController < ApplicationController
  layout 'admin_settings'

  def index
    @collections = current_shop.collections.page(params[:page])
  end

  def select_collection
    render 'index'
  end
end
