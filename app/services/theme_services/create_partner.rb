class ThemeServices::CreatePartner

  attr_reader :success, :result
  alias_method :success?, :success

  def initialize params:
    @result = Partner.new
    @params = params
  end

  def run
    @result.attributes = partner_params
    @success = @result.save
    self
  end

  private

  def partner_params
    @params.slice 'name', 'website_url'
  end
end
