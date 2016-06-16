class ThemeStore::ThemesController < ApplicationController
  layout 'theme_store'
  helper_method :set_sorting_params

  def buy_theme
  end 

  def create_review
  end

  def documentation
  end
  
  def index
    @styles = ThemeStyle
              .industry_category(permitted_params[:industry])
              .themes_price_category(permitted_params[:price])
              .order(permitted_params[:order])
  end

  def preview_in_your_store
  end
  
  def show_author
    @author = Partner.find(params[:id])
  end

  def show_industry_styles
  end
  
  def show_style
    @style = Theme.find(params[:id]).theme_styles.find(params[:style_id])
  end

  def support
  end
    
  def terms_of_service
  end
  
  def view_demo
  end

  private

    def permitted_params
      params.permit(:price, :industry, :order)
    end

    def set_sorting_params(key, value)
      request.params.merge(key.to_sym => value).slice!(:id, :action, :controller, :style_id)
    end

end
