class ThemeStore::ThemesController < ThemeStore::ApplicationController
  include Authenticable
  skip_before_action :authentication_required, except: [:install]
  inherit_resources

  def install
    service = MagazCore::Services::ThemeSystem.new(shop_id: current_user.id, 
                                        source_theme_id: resource.id)
    service.install_theme
    redirect_to theme_store_theme_path(resource)
  end

  protected

  def collection
    @themes ||= MagazCore::Theme.sources
  end

end