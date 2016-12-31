class AdminServices::Link::DeleteLink

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize id:, link_list_id:
    @result = LinkList.friendly.find(link_list_id).links.find(id)
  end

  def run
    @success = @result.destroy
    self
  end
end
