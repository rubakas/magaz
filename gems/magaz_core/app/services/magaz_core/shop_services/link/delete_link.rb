module MagazCore
  module ShopServices
    class DeleteLink < ActiveInteraction::Base

      integer :id

      validates :id, presence: true

      def execute
        MagazCore::Link.find(id).destroy
      end
    end
  end
end