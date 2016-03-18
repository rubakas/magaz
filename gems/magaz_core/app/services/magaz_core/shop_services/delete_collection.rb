module MagazCore
  module ShopServices
    class DeleteCollection < ActiveInteraction::Base

      integer :id

      validates :id, presence: true

      def execute
        MagazCore::Collection.friendly.find(id).destroy
      end
    end
  end
end
