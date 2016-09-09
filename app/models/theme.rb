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

class Theme < ActiveRecord::Base
  module Roles
    MAIN = 'main'.freeze
    UNPUBLISHED = 'unpublished'.freeze
  end

  module PriceCategories
    FREE = "free".freeze
    PREMIUM = "premium".freeze
  end


  scope :price_category, -> (price_category_name) do
    unless price_category_name.blank?
      if price_category_name == PriceCategories::FREE
        where(price: 0)
      elsif price_category_name == PriceCategories::PREMIUM
        where.not(price: 0)
      end
    end
  end

  REQUIRED_DIRECTORIES = %w[assets config layout snippets templates].freeze
  REQUIRED_TEMPLATES = %w[
    templates/blog.liquid
    templates/cart.liquid
    templates/collection.liquid
    templates/index.liquid
    templates/page.liquid
    templates/product.liquid
  ].freeze

  has_many   :assets
  has_many   :installed_themes, class_name: 'Theme', foreign_key: :source_theme_id
  belongs_to :partner
  has_many   :reviews, dependent: :destroy
  belongs_to :shop
  belongs_to :source_theme, class_name: 'Theme', foreign_key: :source_theme_id
  has_many   :theme_styles, dependent: :destroy

  scope :sources,   -> { where(source_theme: nil) }
  scope :installed, -> { where('source_theme_id IS NOT NULL') }
  scope :main,     -> { where(role: Roles::MAIN).first }
  scope :unpublished, -> { where(role: Roles::UNPUBLISHED) }

  validate  :default_directories_present,
            :default_layout_present,
            :default_templates_present,
            # :nested_assets_absent,
            :default_config_present

  def activate!
    self.role = Roles::MAIN
    self.save!
  end

  def deactivate!
    self.role = Roles::UNPUBLISHED
    self.save!
  end

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
    result = _required_asset_present?('layout/theme.liquid')
    #TODO: customize error messages
    errors.add :base, :invalid unless result
    result
  end

  def _required_asset_present?(filename)
    result = assets.select { |a| a.key == filename }.any?
  end

  # templates/[blog, cart, collection, index, page, product].liquid
  def default_templates_present
    result = REQUIRED_TEMPLATES.all? {|t| assets.select {|a| a.key == t} }
    errors.add :base, :invalid unless result
    result
  end

  #TODO: implement nested assets verification
  def nested_assets_absent
    fail
  end

  # config/settings.html
  def default_config_present
    result = _required_asset_present?('config/settings.html')
    #TODO: customize error messages
    errors.add :base, :invalid unless result
    result
  end
end
