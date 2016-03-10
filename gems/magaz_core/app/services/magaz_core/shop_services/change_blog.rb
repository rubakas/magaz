module MagazCore
  module ShopServices
    class ChangeBlog < ActiveInteraction::Base

      string :title, :page_title, :handle, :meta_description
      integer :id, :shop_id

      validate :title_uniqueness, if: :title_changed?

      def execute
        blog = MagazCore::Blog.friendly.find(id)
        blog.update_attributes!(title: title, shop_id: shop_id,
                                page_title: page_title, meta_description: meta_description,
                                handle: handle) ||
          errors.add(:base, "Wrong params for blog")

        blog
      end

      private

      def title_changed?
        MagazCore::Shop.find_by_id(shop_id).blogs.friendly.find(id).title != title
      end

      def title_uniqueness
        errors.add(:base, "Title has already been taken") unless title_unique?
      end

      def title_unique?
        MagazCore::Blog.where(shop_id: shop_id, title: title).count == 0
      end

    end
  end
end