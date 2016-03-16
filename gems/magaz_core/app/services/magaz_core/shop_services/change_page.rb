module MagazCore
  module ShopServices
    class ChangePage < ActiveInteraction::Base

      object :page, class: MagazCore::Page
      string :title, :content, :page_title, :meta_description, :handle
      integer :shop_id

      validate :title_uniqueness, if: :title_changed?

      def execute
        page.update_attributes!(inputs.slice!(:page)) ||
          errors.add(:base, "Wrong params for page")

        page
      end

      private

      def title_changed?
        page.title != title
      end

      def title_uniqueness
        errors.add(:base, "Title has already been taken") unless title_unique?
      end

      def title_unique?
        MagazCore::Page.where(shop_id: shop_id, title: title).count == 0
      end

    end
  end
end