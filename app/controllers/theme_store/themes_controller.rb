class ThemeStore::ThemesController < ApplicationController
  layout 'theme_store'


  def index
    @themes = Theme.price_category(premitted_params[:price]).
                industry_category(premitted_params[:industry]).
                  order(premitted_params[:order])
  end

  private

  def premitted_params
    params.permit(:price, :industry, :order)
  end

end
