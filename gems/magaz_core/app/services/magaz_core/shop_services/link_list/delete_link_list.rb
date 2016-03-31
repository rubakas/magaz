module MagazCore
  module ShopServices
    class DeleteLinkList < ActiveInteraction::Base

      integer :id

      validates :id, presence: true

      def execute
        MagazCore::LinkList.friendly.find(id).destroy
      end
    end
  end
end