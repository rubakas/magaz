class AdminServices::Link::ChangeLink

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize  link_list_id:,
                  id:,
                  params:

    link_list = LinkList
                .friendly
                .find(link_list_id)

    @result = link_list
              .links
              .find(id)

    @params = params
  end

  def run
    @success = @result.update_attributes(link_params)
    self
  end

  private

  def link_params
    @params.slice 'name', 'link_type', 'position'
  end
end
