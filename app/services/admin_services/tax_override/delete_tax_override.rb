class AdminServices::TaxOverride::DeleteTaxOverride

  attr_reader :success, :result
  alias_method :success?, :success

  def initialize(id:)
    @result = ::TaxOverride.find(id)
  end

  def run
     @success = @result.destroy
  end

end
