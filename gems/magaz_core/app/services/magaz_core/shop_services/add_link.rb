module MagazCore
  module ShopServices
    class AddLink < ActiveInteraction::Base

      string :name, :link_type, :position
      integer :link_list_id

      validates :name, :link_list_id, presence: true

      validate :name_uniqueness

      def to_model
        MagazCore::Link.new
      end

      def execute
        link = MagazCore::Link.new(inputs)

        unless link.save
          errors.merge!(link.errors)
        end

        link
      end

      private

      def name_uniqueness
        errors.add(:base, I18n.t('default.services.add_link.title_not_unique')) unless name_unique?
      end

      def name_unique?
        MagazCore::Link.where(link_list_id: link_list_id, name: name).count == 0
      end
    end
  end
end