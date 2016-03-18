module MagazCore
  module ShopServices
    class DeleteCollection < ActiveInteraction::Base

      integer :id

      validates :id, presence: true

      validate :collection_exist?

      def execute
        MagazCore::Collection.friendly.find(id).destroy
      end

      private 

      def collection_exist?
        MagazCore::Collection.friendly.find(id)
      end 

    end
  end
end
