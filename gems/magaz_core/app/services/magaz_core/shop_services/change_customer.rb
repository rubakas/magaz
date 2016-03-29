module MagazCore
  module ShopServices
    class ChangeCustomer < ActiveInteraction::Base

      string :first_name, :last_name, :email
      integer :id, :shop_id

      validates :id, :shop_id, :email, presence: true

      validate :customer_uniqueness, if: :email_changed?

      def execute
        customer = MagazCore::Customer.find(id)
        customer.update_attributes!(inputs.slice!(:id)) ||
          errors.add(:base, I18n.t('default.services.change_customer.wrong_params'))

        customer
      end

      private

      def email_changed?
        MagazCore::Shop.find(shop_id).customers.find(id).email != email 
      end

      def customer_uniqueness
        errors.add(:base, I18n.t('default.services.change_customer.customer_exist')) unless customer_unique?
      end

      def customer_unique?
        MagazCore::Customer.where(shop_id: shop_id, email: email).count == 0
      end   
    end
  end
end