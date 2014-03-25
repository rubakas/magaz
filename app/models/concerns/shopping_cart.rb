module ShoppingCart
  extend ActiveSupport::Concern
  
  included do
    delegate :each, :empty?, to: :line_items
  end

 	#TODO extract service?
  def add_product(product:, quantity: 1)
    raise "Bad quantity" if quantity < 1
    existing_line_item = 
      line_items.find { |li| li.product_id == product.id }
    if existing_line_item
      existing_line_item.inspect
      existing_line_item.quantity += quantity
    else
      new_li_attrs = LineItem.attribute_names.map(&:to_sym) - [:id, :shop_id]
      copied_attrs = product.
        attributes.
        merge({product: product, product_id: product.id, quantity: quantity}).
        select{|k, v| new_li_attrs.include?(k.to_sym) }
      line_items.create(copied_attrs)
    end
  end

  #TODO extract service?
  def update_with_hash(id_qty_hash)
    line_items.clear
    id_qty_hash.each do |k,v|
      add_product(product: Product.find(k), quantity: v.to_i)
    end
    line_items
  end

  def items
    line_items
  end

  def item_count
    line_items.map.sum(&:quantity)
  end

  def total_price
    line_items.map.sum(&:line_price)
  end

  def total_weight
    line_items.map.sum(&:line_weight)
  end

end