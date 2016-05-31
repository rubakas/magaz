class ThemeStore::WelcomeController < ApplicationController
  layout 'theme_store'
  
  def authors_themes
    @author = Partner.find_by_id(params[:id])
    @authors_themes = @author.themes
  end

  def demo
    @author = Partner.find_by_id(params[:id])    
    render layout: "demo_page"
  end

  def homepage
    @themes = Theme.all
  end

  def installing
  end
  
  def learn_more
  end

  def login
  end
  
  def preview_in_store
  end

  def template_page
    @template_themes = Theme.where(industry: params[:industry])
  end

  def theme_page
    @theme = Theme.find_by_id(params[:id])
    @authors_themes = @theme.partner.themes.all
    @styles = @theme.theme_styles.all
    @template_themes = Theme.where(industry: @theme.industry)
    @author = Partner.find_by_id(@theme.partner.id)
  end

end
