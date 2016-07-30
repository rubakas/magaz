class AdminServices::Blog::ChangeBlog

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(blog_id:, shop_id:, params:)
    @result = Shop.find(shop_id).blogs.friendly.find(blog_id)
    @params = params
  end

  def run
    @success = @result.update_attributes(blog_params)
    self
  end

  private

  def blog_params
    @params.slice(:title, :page_title, :handle, :meta_description)
  end
end
