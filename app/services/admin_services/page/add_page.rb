class AdminServices::Page::AddPage
  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(shop_id:, params:)
    @result = Shop.find(shop_id).pages.new(default_params)
    @params = params
  end

  def run
    @result.attributes = page_params
    @success = @result.save
    self
  end

  private

  def page_params
    @params.slice(:title, :content, :page_title, :meta_description, :handle, :publish_on, :published_at)
  end

  def default_params
    {
      page_title: '',
      handle: '',
      meta_description: '',
      publish_on: nil,
      published_at: nil
    }
  end

end
