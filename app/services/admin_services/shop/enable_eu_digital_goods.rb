class AdminServices::Shop::EnableEuDigitalGoods

  attr_reader :success, :shop, :errors
  alias_method :success?, :success

  def initialize  id: nil, collection_name: nil
    @shop_id = id
    @collection_name = collection_name
    @shop = Shop.find(id)
  end

  def run
    _check_default_collection
    @shop.assign_attributes(eu_digital_goods_collection_id: @default_collection.id)
    if @shop.valid?
      @success = true
      @shop.save
    else
      @success = false
      @errors = @shop.errors
    end
    self
  end

  private

  def _check_default_collection
    if default_collection_exists?
      @default_collection = @shop.collections.find_by(name: @collection_name)
    else
      @default_collection = @shop.collections.create(name: @collection_name)
    end
  end

  def default_collection_exists?
    ::Collection.where(shop_id: @shop_id, name: @collection_name).present?
  end

end
