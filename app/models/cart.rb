class Cart
  include ActiveModel::Conversion
  include ActiveModel::Model
  include ActiveModel::Naming

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
    
    def initialize(product:, quantity: 1)
      @product = product
      @quantity = quantity || 0
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

    def quantity
      @quantity.to_i
    end

    def quantity=q
      @quantity = q.to_i || 0
    end
  end

  attr_accessor :attributes, :note
  attr_reader :items
  delegate :each, :empty?, to: :items

  def initialize()
    @attributes = []
    @line_items = []
  end

  def add_product(product:, quantity: 1)
    @line_items = @line_items.reject {|li| li.quantity.nil? || li.quantity < 1}
    existing_line_item = 
      @line_items.find { |li| li.product_id == product.id }
    if existing_line_item
      Rails.logger.fatal existing_line_item.inspect
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

  def update(id_qty_hash)
    line_items = []
    id_qty_hash.each do |k,v|
      line_items << LineItem.new(product: Product.find(k), quantity: v)
    end
    @line_items = line_items
  end

end