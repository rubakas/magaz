class AdminServices::Shop::EnableEuDigitalGoods
  
  attr_reader :success, :result, :errors
  alias_method :success?, :success

  def initialize(id:, collection_name:)
    @errors = {}
    @id = id
    @collection_name = collection_name
    params_validation
    @result = Shop.find(@id) unless @errors[:params].present?    
  end

  def run
    if @result
      check_default_collection 
      @success = @result.update_attributes(eu_digital_goods_collection_id: @default_collection.id)  
    else
      @success = false  
    end  
    self
  end

  private

  def params_validation      
    @errors[:params] = (I18n.t('services.shop_services.wrong_params')) unless params_valid?(@id, @collection_name)
  end

  def params_valid?(id, collection_name)
    return true if id.is_a?(Integer) && collection_name.is_a?(String) && !collection_name.empty?
  end

  def check_default_collection
    if default_collection_exists?
      @default_collection = @result.collections.find_by(name: @collection_name)
    else
      @default_collection = @result.collections.create(name: @collection_name)
    end
  end

  def default_collection_exists?
    ::Collection.where(shop_id: @id, name: @collection_name).present?
  end

end