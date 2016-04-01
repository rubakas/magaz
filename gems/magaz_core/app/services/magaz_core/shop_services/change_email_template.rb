module MagazCore
  module ShopServices
    class ChangeEmailTemplate < ActiveInteraction::Base

      integer :id, :shop_id
      string :title, :body      

      def execute
        email_template = MagazCore::EmailTemplate.find(id)
        email_template.update_attributes!(inputs.slice!(:id)) ||
          errors.add(:base, I18n.t('default.services.change_email_template.wrong_params'))

        email_template
      end
    end
  end
end
