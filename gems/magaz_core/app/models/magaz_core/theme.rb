module MagazCore
  class Theme < ActiveRecord::Base
    self.table_name = 'themes'
    ROLES = %w[main unpublished]

    has_many :assets
    belongs_to :shop
    
    has_many   :installed_themes, class_name: 'MagazCore::Theme', foreign_key: :source_theme_id
    belongs_to :source_theme, class_name: 'MagazCore::Theme', foreign_key: :source_theme_id

    scope :sources,   -> { where(source_theme: nil) }
    scope :installed, -> { where('source_theme_id IS NOT NULL') }
    scope :with_role, -> (role) { where(role: role) }

    scope :current,   -> { where(role: 'main').first }


    validate  :default_directories_present, 
              :default_layout_present,
              :default_templates_present,
              # :nested_assets_absent,
              :default_config_present

    # assets, config, layout, snippets, templates
    def default_directories_present
      default_directories = %w[assets config layout snippets templates]
      directory_names = assets.map do |a| 
        match_data = a.key.match('(.+)/(.+)')
        if match_data
          match_data[1]
        end
      end.compact!
      result = (directory_names == directory_names & default_directories)
      errors.add :base, :invalid unless result
      result
    end

    # theme.liquid
    def default_layout_present
      result = assets.select {|a| a.key == 'layout/theme.liquid'}.any?
      errors.add :base, :invalid unless result
      result
    end
    
    # templates/[blog, cart, collection, index, page, product].liquid
    def default_templates_present
      default_templates = %w[templates/blog.liquid 
        templates/cart.liquid
        templates/collection.liquid
        templates/index.liquid
        templates/page.liquid
        templates/product.liquid
      ]
    end

    #TODO
    def nested_assets_absent
      fail
    end
    
    # config/settings.html
    def default_config_present
      result = assets.select {|a| a.key == 'config/settings.html'}.any?
      errors.add :base, :invalid unless result
      result
    end
  end
end