class ShoppingCartService
	attr_reader :checkout, :customer, :shop

	def initialize(shop_id:, checkout_id:, customer_id:)
		@shop = Shop.find(shop_id)
		@customer = @shop.customers.find_by_id(customer_id) || @shop.customers.create
		@checkout = @customer.checkouts.not_orders.find_by_id(checkout_id) || @customer.checkouts.create
	end

	def save_cart
		@checkout.save
	end

	def update_with_hash(hash)
		@checkout.update_with_hash(hash)
	end

	def add_product(product:, quantity:)
		@checkout.add_product(product: product, quantity: quantity)
	end
end