class AdminServices::Article::ChangeArticle

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(blog_id:, article_id:, params:)
    @result = Article.friendly.find(article_id)
    @result.blog_id = blog_id
    @result.blog = Blog.friendly.find(blog_id)
    @params = params
  end

  def run
    @success = @result.update_attributes(article_params)
    self
  end

  private

  def default_params
    { handle: '', page_title: '', meta_description: '' }
  end

  def article_params
    @params.slice(:title, :content, :page_title, :handle, :meta_description)
  end
end
