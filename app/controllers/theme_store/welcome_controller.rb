class ThemeStore::WelcomeController < ApplicationController
  layout 'theme_store'
  
  def authors_themes
    @authors_themes = Partner.first.themes
  end

  def demo
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
    @template_themes = Theme.all
  end

  def theme_page
    @theme = Theme.first
    @authors_themes = Theme.first.partner.themes.all
    @styles = Theme.first.theme_styles.all
    @template_themes = Theme.all
  end

end
