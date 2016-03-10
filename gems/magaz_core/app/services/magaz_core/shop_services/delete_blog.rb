module MagazCore
  module ShopServices
    class DeleteBlog < ActiveInteraction::Base

      integer :id

      validates :id, presence: true

      validate :blog_exist?

      def execute
        MagazCore::Blog.friendly.find(id).destroy
      end

      private

      def blog_exist?
        MagazCore::Blog.friendly.find(id)
      end
    end
  end
end