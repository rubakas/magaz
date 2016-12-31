class StoreServices::ShoppingCart::CartUpdateWithHash

  attr_reader :success, :errors, :checkout
  alias_method :success?, :success

  def initialize  shop_id: nil,
                  checkout_id: nil,
                  customer_id: nil,
                  id_qty_hash: nil
    @shop     = Shop.find(shop_id)
    @customer = @shop.customers.find_by_id(customer_id) || @shop.customers.new
    @customer.save!(validate: false)
    @checkout = @customer.checkouts.not_orders.find_by_id(checkout_id) || @customer.checkouts.create
    @id_qty_hash = id_qty_hash
  end

  def run
    _update_with_hash
    @success = true
    self
  end

  private

  def _update_with_hash
    @checkout.line_items.clear
    @id_qty_hash.each do |k, v|
      StoreServices::ShoppingCart::AddProductToCart
      .new( shop_id:      @shop.id,
            checkout_id:  @checkout.id,
            customer_id:  @customer.id,
            product_id:   k,
            quantity:     v.to_i)
      .run
    end
    @checkout = @shop.checkouts.find(@checkout.id)
  end
end
