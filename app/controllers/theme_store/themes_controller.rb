class ThemeStore::ThemesController < ApplicationController
  layout 'theme_store'


  def index
    @themes = Theme.price_category(permitted_params[:price]).
                industry_category(permitted_params[:industry]).
                  order(permitted_params[:order])
  end

  private

  def permitted_params
    params.permit(:price, :industry, :order)
  end

end
