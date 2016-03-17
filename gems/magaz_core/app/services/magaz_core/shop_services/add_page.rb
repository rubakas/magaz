module MagazCore
  module ShopServices
    class AddPage < ActiveInteraction::Base

      string :title, :content, :page_title, :meta_description, :handle
      integer :shop_id

      validates :title, :shop_id, presence: true

      validate :title_uniqueness

      def to_model
        MagazCore::Page.new
      end

      def execute
        page = MagazCore::Page.new(inputs)

        unless page.save
          errors.merge!(page.errors)
        end

        page
      end

      private

      def title_uniqueness
        errors.add(:base, "Title has already been taken") unless title_unique?
      end

      def title_unique?
        MagazCore::Page.where(shop_id: shop_id, title: title).count == 0
      end
    end
  end
end