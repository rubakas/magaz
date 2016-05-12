class ThemesStoreController < ApplicationController
  layout "theme_store"

  def learn_more
  end
  
  def demo
    render layout: "demo_page"
  end

end
