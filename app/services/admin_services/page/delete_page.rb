class AdminServices::Page::DeletePage
  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(shop_id:, id:)
    @result = ::Shop.find(shop_id).pages.friendly.find(id)
  end

  def run
    @success = @result.destroy
    self
  end
end
