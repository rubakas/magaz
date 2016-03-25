module MagazCore
  module ShopServices
    class AddComment < ActiveInteraction::Base

      string :author, :email, :body
      integer :article_id, :blog_id

      validates :author, :body, :email, :article_id, :blog_id, presence: true

      validate :blog_existence, :article_belongs, :article_existence

      def to_model
        MagazCore::Comment.new
      end

      def execute
        comment = MagazCore::Comment.new(inputs)

        unless comment.save
          errors.merge!(comment.errors)
        end
        
        comment
      end

      private

      def blog_existence
        errors.add(:base, I18n.t('default.services.add_comment.blog_not_exist')) unless blog_exist?
      end

      def article_existence
        errors.add(:base, I18n.t('default.services.add_comment.article_not_exist')) unless article_exist?
      end

      def article_belongs
        errors.add(:base, I18n.t('default.services.add_comment.article_not_belongs')) unless article_belongs_to_blog?
      end

      def blog_exist?
        MagazCore::Blog.find_by_id(blog_id)
      end 

      def article_exist?
        MagazCore::Article.find(article_id)
      end

      def article_belongs_to_blog?
        MagazCore::Article.find(article_id).blog_id == blog_id
      end
    end
  end
end
