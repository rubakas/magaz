class ThemeStore::ThemesController < ApplicationController
  layout 'theme_store'


  def index
    @industries = ["Art & Photography", "Clothing & Fashion", "Electronics", "Food & Drink",
                   "Health & Beauty", "Home & Garden", "Jewelry & Accessories", "Other",
                   "Responsive", "Sports & Recreation", "Toys & Games" ]

    @themes = Theme.all

    if "free" == premitted_params[:price]
      @themes = @themes.where(price: 0)
    elsif "paid" == premitted_params[:price]
      @themes = @themes.where.not(price: 0)      
    else
      @themes
    end

    if premitted_params[:industry] && premitted_params[:industry] != ''
      @themes = @themes.where(industry: premitted_params[:industry])
    end
    
    @themes = @themes.order(premitted_params[:order])
  end

  private

  def premitted_params
    params.permit(:price, :industry, :order)
  end

end
