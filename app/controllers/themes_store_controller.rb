class ThemesStoreController < ApplicationController
  layout "theme_store"

  def learn_more
  end
  
  def preview
    render layout: "preview_page"
  end

end
