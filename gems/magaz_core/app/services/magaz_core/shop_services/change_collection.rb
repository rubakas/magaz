module MagazCore
  module ShopServices
    class ChangeCollection < ActiveInteraction::Base

      object :collection, class: MagazCore::Collection
      string :name, :page_title, :handle, :meta_description, :description
      integer :shop_id

      validate :name_uniqueness, if: :name_changed?

      def execute
        collection.update_attributes!(inputs.slice!(:collection)) ||
          errors.add(:base, "Wrong params for collection")

        collection
      end

      private

      def name_changed?
        collection.name != name
      end

      def name_uniqueness
        errors.add(:base, "Name has already been taken") unless name_unique?
      end

      def name_unique?
        MagazCore::Collection.where(shop_id: shop_id, name: name).count == 0
      end

    end
  end
end