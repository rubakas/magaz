module MagazCore
  module ShopServices
    class ChangeArticle < ActiveInteraction::Base

      string :title, :content, :page_title, :handle, :meta_description
      integer :id, :blog_id

      validates :title, :blog_id, presence: true

      validate :title_uniqueness

      def execute
        article = MagazCore::Article.find(id)
        article.update_attributes!(title: title, content: content,
                                   blog_id: blog_id, page_title: page_title,
                                   meta_description: meta_description, handle: handle)

        unless article.save
          errors.merge!(article.errors)
        end
      end

      private

      def title_uniqueness
        errors.add(:base, "Title has already been taken") unless title_unique?
      end

      def title_unique?
        blog = MagazCore::Blog.find_by_id(blog_id)
        !blog.articles.find_by(title: title)
      end
    end
  end
end