class AdminServices::LinkList::AddLinkList

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize shop_id:, params:
    @result = Shop.find(shop_id)
              .link_lists.new(default_params)
    @params = params
  end

  def run
    @result.attributes = link_lists_params
    @success = @result.save
    self
  end

  private

  def link_lists_params
    @params.slice 'name',
                  'handle'
  end

  def default_params
    { 'handle' => '' }
  end

end
