class AdminServices::Collection::AddCollection
  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(shop_id:, params:)
    @result = Shop.find(shop_id).collections.new
    @params = params
  end

  def run
    @result.attributes = collection_params
    @success = @result.save
    # TODO: check errors display after refactoring
    # unless @collection.update_attributes(inputs)
    #   errors.merge!(@collection.errors)
    # end
    self
  end

  private
  def collection_params
    @params.slice(:name, :description, :page_title, :meta_description, :handle)
  end
end
