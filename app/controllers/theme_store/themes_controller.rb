class ThemeStore::ThemesController < ApplicationController
  layout 'theme_store'
  helper_method :set_sorting_params

  def index
    @styles = ThemeStyle
              .industry_category(permitted_params[:industry])
              .themes_price_category(permitted_params[:price])
              .order(permitted_params[:order])
  end

  def show_style
    @style = Theme.find(params[:id]).theme_styles.find(params[:style_id])
  end

  def show_author
  end  

  def show_industry_styles
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

    def set_sorting_params(key, value)
      request.params.merge(key.to_sym => value).slice!(:id, :action, :controller)
    end

end
