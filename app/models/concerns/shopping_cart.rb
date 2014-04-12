#TODO looks like decorator to me
module ShoppingCart
  extend ActiveSupport::Concern
  
  included do
    delegate :each, :empty?, to: :line_items
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