module MagazCore
  module ShopServices
    class AddCustomer < ActiveInteraction::Base

      string :first_name
      integer :shop_id
      string :last_name, :email, default: nil

      validates :first_name, presence: true

      validate :customer_uniquness

      def to_model
        MagazCore::Customer.new
      end

      def execute
        customer = MagazCore::Customer.new(inputs)

        unless customer.save
          errors.merge!(customer.errors)
        end

        customer
      end

      def customer_uniquness
        errors.add(:base, I18n.t('default.services.add_customer.customer_exist')) unless customer_unique?
      end

      def customer_unique?
        MagazCore::Customer.where(shop_id: shop_id, first_name: first_name).count == 0
      end
    end
  end
end