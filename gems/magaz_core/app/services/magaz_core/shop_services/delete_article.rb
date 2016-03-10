module MagazCore
  module ShopServices
    class DeleteArticle < ActiveInteraction::Base

      object :article, class: MagazCore::Article

      validates :article, presence: true

      def execute
        article.destroy
      end
    end
  end
end