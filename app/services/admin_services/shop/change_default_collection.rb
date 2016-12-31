class AdminServices::Shop::ChangeDefaultCollection
  NUMBER_REGEX = /\A[-+]?\d*\.?\d+\z/

  attr_reader :success, :shop, :errors
  alias_method :success?, :success

  def initialize  id:,
                  collection_id:
    @id = id
    @collection_id = collection_id
    @shop = Shop.find(@id)
  end

  def run
    @shop.assign_attributes(eu_digital_goods_collection_id: @collection_id)
    if @shop.valid?
      @shop.save
      @success = true
    else
      @errors = @shop.errors
      @success = false
    end
    self
  end
end
