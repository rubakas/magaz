# == Schema Information
#
# Table name: themes
#
#  id              :integer          not null, primary key
#  name            :string
#  created_at      :datetime
#  updated_at      :datetime
#  shop_id         :integer
#  source_theme_id :integer
#  role            :string
#

module MagazCore
  class Theme < ActiveRecord::Base
    self.table_name = 'themes'
    REQUIRED_DIRECTORIES = %w[assets config layout snippets templates].freeze
    
    has_many :assets
    has_many   :installed_themes, class_name: 'MagazCore::Theme', foreign_key: :source_theme_id
    belongs_to :shop
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
      directory_names = assets.map do |a| 
        match_data = a.key.match('([^\/]+)\/')
        match_data[1] if match_data
      end.compact
      .uniq

      result = (directory_names == directory_names & REQUIRED_DIRECTORIES)
      #TODO: customize error messages
      errors.add :base, :invalid unless result
      result
    end

    # theme.liquid
    def default_layout_present
      result = assets.select { |a| a.key == 'layout/theme.liquid' }.any?
      #TODO: customize error messages
      errors.add :base, :invalid unless result
      result
    end
    
    # templates/[blog, cart, collection, index, page, product].liquid
    def default_templates_present
      default_templates = %w[
        templates/blog.liquid 
        templates/cart.liquid
        templates/collection.liquid
        templates/index.liquid
        templates/page.liquid
        templates/product.liquid
      ]
    end

    #TODO: implement nested assets verification
    def nested_assets_absent
      fail
    end
    
    # config/settings.html
    def default_config_present
      result = assets.select { |a| a.key == 'config/settings.html' }.any?
      #TODO: customize error messages
      errors.add :base, :invalid unless result
      result
    end
  end
end
