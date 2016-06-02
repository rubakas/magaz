class ThemeStore::ThemesController < ApplicationController
  layout 'theme_store'


  def index
    @styles = ThemeStyle.industry_category(permitted_params[:industry])
                .joins(:theme).merge(Theme.price_category(permitted_params[:price]))
                  .order(permitted_params[:order])
  end

  private

  def permitted_params
    params.permit(:price, :industry, :order)
  end

end
