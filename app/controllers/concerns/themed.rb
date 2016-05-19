module Concerns
  module Themed
    extend ActiveSupport::Concern

    included do
      append_view_path ThemeServices::Resolver.instance
    end

    class ::ActionView::LookupContext
      register_detail(:themes) {}
    end

    def _process_options(options)
      options[:themes] = current_shop.themes.installed.map
      super(options)
    end
  end
end
