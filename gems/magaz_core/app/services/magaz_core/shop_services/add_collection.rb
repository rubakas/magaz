module MagazCore
  module ShopServices
    class AddCollection < ActiveInteraction::Base

      string :name, :description, :page_title, :meta_description, :handle
      integer :shop_id

      validates :name, :shop_id, presence: true

      validate :name_uniqueness

      def to_model
        MagazCore::Collection.new
      end

      def execute
        collection = MagazCore::Collection.new(inputs)

        unless collection.save
          errors.merge!(collection.errors)
        end

        collection
      end

      private

      def name_uniqueness
        errors.add(:base, "Name has already been taken") unless name_unique?
      end

      def name_unique?
        MagazCore::Collection.where(shop_id: shop_id, name: name).count == 0
      end
    end
  end
end