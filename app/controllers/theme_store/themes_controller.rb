class ThemeStore::ThemesController < ApplicationController
  layout 'theme_store'
  helper_method :sort_by

  def index
    @styles = ThemeStyle.industry_category(permitted_params[:industry])
                .themes_price_category(permitted_params[:price])
                  .order(permitted_params[:order])
  end

  def show_style
    @style = ThemeStyle.find_by_id(params[:id])
    @industry_styles = ThemeStyle.get_industry_styles(@style)
    @theme = @style.theme
    @author = @theme.partner
    @authors_styles = ThemeStyle.get_partner_styles(@author)
  end

  def show_author
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

    def sort_by(key, value)
      request.params.merge(key.to_sym => value).slice!(:id, :action, :controller)
    end

end
