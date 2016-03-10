module MagazCore
  module ShopServices
    class ChangeArticle < ActiveInteraction::Base

      object :article, class: MagazCore::Article

      string :title, :content, :page_title, :handle, :meta_description
      integer :blog_id

      validates :article, presence: true

      validate :title_uniqueness, if: :title_changed?

      def execute
        article.update_attributes!(inputs.slice!(:article)) ||
          errors.add(:base, "Wrong params for article")

        article
      end

      private

      def title_changed?
        article.title != title
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