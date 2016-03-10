module MagazCore
  module ShopServices
    class AddBlog < ActiveInteraction::Base

      string :title, :page_title, :meta_description, :handle
      integer :shop_id

      validates :title, :shop_id, presence: true

      validate :title_uniqueness

      def to_model
        MagazCore::Blog.new
      end

      def execute
        blog = MagazCore::Blog.new(title: title, shop_id: shop_id, page_title: page_title,
                                      meta_description: meta_description, handle: handle)

        unless blog.save
          errors.merge!(blog.errors)
        end

        blog
      end

      private

      def title_uniqueness
        errors.add(:base, "Title has already been taken") unless title_unique?
      end

      def title_unique?
        MagazCore::Blog.where(shop_id: shop_id, title: title).count == 0
      end
    end
  end
end