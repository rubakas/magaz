module MagazCore
  module ShopServices
    class DeleteArticle < ActiveInteraction::Base

      integer :id

      validates :id, presence: true

      validate :article_exist?

      def execute
        MagazCore::Article.friendly.find(id).destroy
      end

      private

      def article_exist?
        MagazCore::Article.friendly.find(id)
      end
    end
  end
end