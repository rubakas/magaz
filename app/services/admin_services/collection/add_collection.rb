class AdminServices::Collection::AddCollection
  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(shop_id:, params:)
    @result = ::Shop.find(shop_id).collections.new(default_params)
    @params = params
  end

  def run
    @success = @result.update_attributes(collection_params)
    self
  end

  private

  def default_params
    { handle: '', description: '', page_title: '', meta_description: '' }
  end

  def collection_params
    @params.slice(:name, :description, :page_title, :meta_description, :handle)
  end
end
