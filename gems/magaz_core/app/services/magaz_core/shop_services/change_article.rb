module MagazCore
  module ShopServices
    class ChangeArticle < ActiveInteraction::Base

      string :title, :content, :page_title, :handle, :meta_description
      integer :id, :blog_id

      validate :title_uniqueness, if: :title_changed?

      def execute
        article = MagazCore::Article.friendly.find(id)
        article.update_attributes!(title: title, content: content,
                                   blog_id: blog_id, page_title: page_title,
                                   meta_description: meta_description, handle: handle) ||
          errors.add(:base, "Wrong params for article")

        article
      end

      private

      def title_changed?
        MagazCore::Article.friendly.find(id).title != title
      end

      def title_uniqueness
        errors.add(:base, "Title has already been taken") unless title_unique?
      end

      def title_unique?
        MagazCore::Article.where(blog_id: blog_id, title: title).count == 0
      end

    end
  end
end