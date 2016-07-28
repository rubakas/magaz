class AdminServices::Link::AddLink

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(link_list_id:, params:)
    link_list = LinkList.friendly.find(link_list_id)
    @result = link_list.links.new(default_params)
    @params = params
  end

  def run
    @result.attributes = link_params
    @success = @result.save
    self
  end

  private

  def link_params
    @params.slice(:name, :link_type, :position)
  end

  def default_params
    { position: '', link_type: '' }
  end

end
