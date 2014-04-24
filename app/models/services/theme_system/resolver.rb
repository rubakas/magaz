require "singleton"

class Services::ThemeSystem::Resolver < ActionView::Resolver
  include Singleton
  
  def find_all(name, prefix=nil, partial=false, details={}, key=nil, locals=[])
    @theme = details[:theme].first # it is an array
    find_templates(name, prefix, partial, details)
  end

  private

  def theme
    @theme
  end

  def find_templates(name, prefix, partial, details)
    asset_key = normalize_path(name, prefix)
    found_assets = theme.assets.all.where(key: asset_key)
    templates = found_assets.map { |a| initialize_template(a, partial) }
    templates
  end

  # Normalize name and prefix, so the tuple ["index", "users"] becomes 
  # "users/index" and the tuple ["template", nil] becomes "template".
  def normalize_path(name, prefix)
    prefix.present? ? "#{prefix}/#{name}" : name
  end

  # Make paths as "users/user" become "users/_user" for partials.
  def virtual_path(path, partial)
    return path unless partial
    if index = path.rindex("/")
      path.insert(index + 1, "_")
    else
      "_#{path}"
    end
  end

  def initialize_template(asset, partial)
    source = asset.value
    identifier = "Asset - #{asset.id} - #{asset.key.inspect}"
    handler = ActionView::Template.registered_template_handler(:erb)
    details = {
      format: Mime[:html],
      updated_at: asset.updated_at,
      virtual_path: virtual_path(asset.key, partial)
    }
    ActionView::Template.new(source, identifier, handler, details)
  end

end