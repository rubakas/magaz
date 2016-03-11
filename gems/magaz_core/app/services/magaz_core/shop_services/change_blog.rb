module MagazCore
  module ShopServices
    class ChangeBlog < ActiveInteraction::Base

      object :blog, class: MagazCore::Blog
      string :title, :page_title, :handle, :meta_description
      integer :shop_id

      validate :title_uniqueness, if: :title_changed?

      def execute
        blog.update_attributes!(inputs.slice!(:blog)) ||
          errors.add(:base, "Wrong params for blog")

        blog
      end

      private

      def title_changed?
        blog.title != title
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