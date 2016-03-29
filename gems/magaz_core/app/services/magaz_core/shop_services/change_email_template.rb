module MagazCore
  module ShopServices
    class ChangeEmailTemplate < ActiveInteraction::Base

      integer :id, :shop_id
      string :name, :title, :body, :template_type      

      validates :name, presence: true

      validate :name_uniqueness, if: :name_changed?

      def execute
        email_template = MagazCore::EmailTemplate.find(id)
        email_template.update_attributes!(inputs.slice!(:id)) ||
          errors.add(:base, I18n.t('default.services.change_email_template.wrong_params'))

        email_template
      end

      private

      def name_changed?
        MagazCore::Shop.find(shop_id).email_templates.find(id).name != name
      end

      def name_uniqueness
        errors.add(:base, I18n.t('default.services.change_email_template.name_not_unique')) unless name_unique?
      end

      def name_unique?
        MagazCore::EmailTemplate.where( name: name, shop_id: shop_id).count == 0
      end
    end
  end
end
