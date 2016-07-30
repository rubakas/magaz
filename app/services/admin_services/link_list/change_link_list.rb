class AdminServices::LinkList::ChangeLinkList

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(id:, shop_id:, params:)
    @result = Shop.find(shop_id).link_lists.friendly.find(id)
    @params = params
  end

  def run
    @success = @result.update_attributes(link_lists_params)
    self
  end

  private

  def link_lists_params
    @params.slice(:name, :handle)
  end
end
