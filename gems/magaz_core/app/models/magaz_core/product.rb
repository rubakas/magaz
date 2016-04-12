# == Schema Information
#
# Table name: products
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :text
#  created_at       :datetime
#  updated_at       :datetime
#  shop_id          :integer
#  price            :decimal(38, 2)
#  handle           :string
#  page_title       :string
#  meta_description :string
#  slug             :string
#  publish_on       :datetime
#  published_at     :datetime
#

module MagazCore
  class Product < ActiveRecord::Base
    self.table_name = 'products'
    extend FriendlyId
    include Concerns::Visibility

    has_and_belongs_to_many :collections, class_name: 'MagazCore::Collection'
    has_many :product_images, class_name: 'MagazCore::ProductImage', :dependent => :destroy
    belongs_to :shop
    has_many :events, as: :subject

    friendly_id :handle, use: [:slugged, :scoped], scope: :shop

    accepts_nested_attributes_for :product_images, :allow_destroy => true

    validates :name, presence: true, uniqueness: { scope: :shop_id }

    def should_generate_new_friendly_id?
      handle_changed?
    end

  end
end
