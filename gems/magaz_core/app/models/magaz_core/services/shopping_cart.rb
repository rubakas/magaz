module MagazCore
  module Services
    class ShoppingCart
      attr_reader :checkout, :customer, :shop

      def initialize(shop_id:, checkout_id:, customer_id:)
        @shop     = Shop.find(shop_id)
        @customer = @shop.customers.find_by_id(customer_id) || @shop.customers.create
        @checkout = @customer.checkouts.not_orders.find_by_id(checkout_id) || @customer.checkouts.create
      end

      def save_cart
        @checkout.save
      end

      def update_with_hash(id_qty_hash)
        @checkout.line_items.clear
        id_qty_hash.each do |k, v|
          #TODO:  product not found
          add_product(product: @shop.products.find(k), quantity: v.to_i)
        end
        @checkout.line_items
      end

      def add_product(product:, quantity:)
        raise "Bad quantity" if quantity < 1
        @checkout.line_items
        existing_line_item =
          @checkout.line_items.find { |li| li.product_id == product.id }

        if existing_line_item
          existing_line_item.inspect
          existing_line_item.quantity += quantity
        else
          new_li_attrs = LineItem.attribute_names.map(&:to_sym) - [:id, :shop_id]
          copied_attrs = product
            .attributes
            .merge({ product: product, product_id: product.id, quantity: quantity })
            .select { |k, v| new_li_attrs.include?(k.to_sym) }
          @checkout.line_items.create(copied_attrs)
        end
      end

      def update_address(address_attrs)
        @checkout.update(address_attrs)
      end

      #TODO:  connect with payment processor, pay method
      def checkout_to_order(order_attrs)
        attrs = { :status => 'open' }.merge order_attrs
        @checkout.update(attrs)
        email_template = @shop.email_templates.find_by(template_type: 'new_order_notification')
        @shop.subscriber_notifications.each do |s|
          MagazCore::UserMailer.notification(s, email_template).deliver_now
        end
      end
    end
  end
end