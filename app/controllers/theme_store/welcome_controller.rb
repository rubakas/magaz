class ThemeStore::WelcomeController < ApplicationController
  layout 'theme_store'
  
  def authors_themes
    @authors_themes = Theme.all.to_a*10
  end

  def demo
    render layout: "demo_page"
  end

  def homepage
    @themes = Theme.all.to_a*10
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
    @template_themes = Theme.all.to_a*10
  end

  def theme_page
    @theme = Theme.first
    @authors_themes = Theme.all.to_a*10
    @styles = Theme.all.to_a*10
    @template_themes = Theme.all.to_a*10
  end

end
