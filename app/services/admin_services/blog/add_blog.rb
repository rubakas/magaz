class AdminServices::Blog::AddBlog

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize  shop_id:, 
                  params:
    @result = Shop.find(shop_id).blogs.new(default_params)
    @params = params
  end

  def run
    @result.attributes = blog_params
    @success = @result.save
    self
  end

  private

  def default_params
    { 'meta_description' => '', 'handle' => '', 'page_title' => '' }
  end

  def blog_params
    @params.slice 'meta_description',
                  'handle',
                  'page_title',
                  'title'
  end
end
