class AdminServices::Collection::ChangeCollection
  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize  shop_id:,
                  id:,
                  params:
    @result = Shop
              .find(shop_id)
              .collections
              .friendly
              .find(id)
    @params = params
  end

  def run
    @success = @result.update_attributes(collection_params)
    self
  end

  private

  def collection_params
    @params.slice 'name',
                  'description',
                  'page_title',
                  'meta_description',
                  'handle'
  end
end
