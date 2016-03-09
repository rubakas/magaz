module MagazCore
  module ShopServices
    class AddArticle < ActiveInteraction::Base

      string :title, :content, :page_title, :handle, :meta_description
      integer :blog_id

      validates :title, :blog_id, presence: true

      validate :title_uniqueness

      def to_model
        MagazCore::Article.new
      end

      def execute
        article = MagazCore::Article.new(title: title, content: content,
                                         blog_id: blog_id, page_title: page_title,
                                         meta_description: meta_description, handle: handle)

        unless article.save
          errors.merge!(article.errors)
        end

        article
      end

      private

      def title_uniqueness
        errors.add(:base, "Title has already been taken") unless title_unique?
      end

      def title_unique?
        MagazCore::Article.where(blog_id: blog_id, title: title).count == 0
      end
    end
  end
end