class ThemeStore::WelcomeController < ApplicationController
  layout 'theme_store'
  
  def authors_themes
    @authors_themes = Array.new
    for i in 0..5
      @authors_themes << Theme.first
    end
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
    @template_themes = Array.new
    for i in 0..5
      @template_themes << Theme.last
    end
  end

  def theme_page
    @theme = Theme.first
    @authors_themes = @template_themes = @styles = Array.new
    for i in 0..5
      @authors_themes << Theme.first
      @styles << Theme.first
      @template_themes << Theme.last
    end
  end

end
