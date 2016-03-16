module MagazCore
  module ShopServices
    class AddLinkList < ActiveInteraction::Base

      string :name, :handle
      integer :shop_id

      validates :name, :shop_id, presence: true

      validate :name_uniqueness

      def execute
        link_list = MagazCore::LinkList.new(inputs)

        unless link_list.save
          errors.merge!(link_list.errors)
        end

        link_list
      end

      private

      def name_uniqueness
        errors.add(:base, "Name has already been taken") unless name_unique?
      end

      def name_unique?
        MagazCore::LinkList.where(shop_id: shop_id, name: name).count == 0
      end
    end
  end
end