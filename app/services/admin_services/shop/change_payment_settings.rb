class AdminServices::Shop::ChangePaymentSettings

  attr_reader :success, :result, :errors
  alias_method :success?, :success

  def initialize(id:, authorization_settings:)
    @errors = {}
    @id = id
    @authorization_settings = authorization_settings
    params_validation
    @result = Shop.find(@id) unless @errors[:params].present?    
  end

  def run
    @success = @result.update_attributes!(shop_params)
    self
  end

  private

  def params_validation      
    @errors[:params] = (I18n.t('services.shop_services.wrong_params')) unless params_valid?(@id, @authorization_settings)
  end

  def params_valid?(id, authorization_settings)
    return true if id.is_a?(Integer) && authorization_settings.is_a?(String) && !authorization_settings.empty?
  end

  def shop_params
    params = inputs.slice!(:id)
    params[:authorization_settings] = nil unless authorization_method_included?
    params
  end

  def authorization_method_included?
    %w[ authorize_and_charge authorize ].include?(@authorization_settings)
  end

end