class ThemeStore::ThemesController < ApplicationController
  layout 'theme_store'


  def index
    @styles = ThemeStyle.industry_category(permitted_params[:industry])
                .themes_price_category(permitted_params[:price])
                  .order(permitted_params[:order])
  end

  def show_style
    @authors_styles = []
    @style = ThemeStyle.find_by_id(params[:id])
    @template_styles = ThemeStyle.where.not(id: params[:id]).where(industry: @style.industry)
    @theme = @style.theme
    @theme_styles = @theme.theme_styles
    @author = Partner.find_by_id(@theme.partner.id)
    @author.themes.each do |theme|
      theme.theme_styles.each do |style|
        @authors_styles << style
      end
    end
    @authors_styles = @authors_styles.take(3)
  end

  def preview_in_your_store
  end
  
  def buy_theme
  end
  
  def view_demo
  end
  
  def support
  end
    
  def documentation
  end
  
  def terms_of_service
  end

  private

  def permitted_params
    params.permit(:price, :industry, :order)
  end

end
