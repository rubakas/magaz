class AdminServices::Shop::ChangeDefaultCollection
  NUMBER_REGEX = /\A[-+]?\d*\.?\d+\z/

  attr_reader :success, :result, :errors
  alias_method :success?, :success

  def initialize(id:, collection_id:)
    @errors = {}
    @id = id
    @collection_id = collection_id
    params_validation
    @result = Shop.find(@id) unless @errors[:params].present?    
  end

  def run
    check_collection_existence
    if @errors[:collection].present?
      @succes = false
    else  
      @success = @result.update_attributes(eu_digital_goods_collection_id: @collection_id)
    end  
    self
  end

  private

  def check_collection_existence
    @errors[:collection] = (I18n.t('services.shop_services.wrong_collection')) unless collection_exists?
  end

  def params_validation      
    @errors[:params] = (I18n.t('services.shop_services.wrong_params')) unless params_valid?(@id, @collection_id)
  end  

  def collection_exists?
    ::Collection.where(shop_id: @id, id: @collection_id).present?
  end

  def params_valid?(id, collection_id)
    return true if id.to_s =~ NUMBER_REGEX && collection_id.to_s =~ NUMBER_REGEX
  end

end
