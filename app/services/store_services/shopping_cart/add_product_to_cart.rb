class StoreServices::ShoppingCart::AddProductToCart

  attr_reader :success, :errors, :checkout
  alias_method :success?, :success

  def initialize(shop_id: nil, checkout_id: nil, customer_id: nil, product_id: nil, quantity: nil)
    @shop     = Shop.find(shop_id)
    @customer = @shop.customers.find_by_id(customer_id) || @shop.customers.new
    @customer.save!(validate: false)
    @checkout = @customer.checkouts.not_orders.find_by_id(checkout_id) || @customer.checkouts.create
    @product  = @shop.products.find(product_id)
    @quantity = quantity
  end

  def run
    _add_product
    self
  end

  private

  def _add_product
    if @quantity < 1
      @success = false
      @checkout.errors.add(:base, I18n.t('services.store_services.add_product_to_cart.invalid_quantity'))
      @errors = @checkout.errors
    else
      _existing_line_item
      _add_new_line_item
    end
  end

  def _existing_line_item
    if @checkout.line_items.find { |li| li.product_id == @product.id }
      line_item.inspect
      line_item.quantity += @quantity
    end
  end

  def _add_new_line_item
    if _existing_line_item == nil
      new_li_attrs = LineItem.attribute_names.map(&:to_sym) - [:id, :shop_id]
      copied_attrs = @product
        .attributes
        .merge({ 'product' => @product, 'product_id' => @product.id, 'quantity' => @quantity })
        .select { |k, v| new_li_attrs.include?(k.to_sym) }
      @checkout.line_items.create(copied_attrs)
    end
  end

end
