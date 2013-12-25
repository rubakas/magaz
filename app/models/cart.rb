class Cart
  class LineItem
    attr_accessor :quantity
    attr_reader :product, 
      :product_id,
      :line_price
    
    delegate :id, 
      :grams,
      :name, 
      :price, 
      to: :product
    
    def initialize(product:, quantity:)
      @product = product
      @quantity = quantity
    end

    def product_id
      @product.id
    end

    def line_price
      price * quantity
    end

    def line_weight
      grams * quantity
    end
  end

  attr_accessor :attributes, :note
  attr_reader :items
  delegate :each, :empty?, to: :items

  def initialize()
    @attributes = []
    @line_items = []
  end

  def add_product(product:, quantity:)
    existing_line_item = 
      @line_items.find { |li| li.product_id == product.id }
    if existing_line_item
      existing_line_item.quantity += quantity
    else
      @line_items << LineItem.new(product: product, quantity: quantity)
    end
  end

  def items
    @line_items
  end

  def item_count
    @line_items.sum(&:quantity)
  end

  def total_price
    @line_items.sum(&:line_price)
  end

  def total_weight
    @line_items.sum(&:line_weight)
  end

end