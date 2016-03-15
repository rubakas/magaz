module MagazCore
  module ShopServices
    class DeleteCheckout < ActiveInteraction::Base

      integer :id

      validates :id, presence: true

      validate :checkout_exist?

      def execute
        MagazCore::Checkout.find(id).destroy
      end

      private

      def checkout_exist?
        MagazCore::Checkout.find(id)
      end
    end
  end
end