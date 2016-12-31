class AdminServices::Page::ChangePage
  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(id:, shop_id:, params:)
    @result = Shop.find(shop_id).pages.friendly.find(id)
    @params = params
  end

  def run
    @success = @result.update_attributes(page_params)
    self
  end

  private

  def page_params
    @params.slice 'title',
                  'content',
                  'page_title',
                  'meta_description',
                  'handle',
                  'publish_on',
                  'published_at'
  end
end
