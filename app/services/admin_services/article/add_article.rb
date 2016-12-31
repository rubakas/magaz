class AdminServices::Article::AddArticle

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(blog_id:, params:)
    @result = Blog.find(blog_id).articles.new(default_params)
    @params = params.with_indifferent_access
  end

  def run
    @result.attributes = article_params
    @success = @result.save
    self
  end

  private

  def default_params
    { 'handle' => '', 'page_title' => '', 'meta_description' => '' }
  end

  def article_params
    @params.slice 'title', 
                  'content',
                  'page_title',
                  'handle',
                  'meta_description'
  end
end
