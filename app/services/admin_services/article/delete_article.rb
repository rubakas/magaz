class AdminServices::Article::DeleteArticle

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize id:
    @result = ::Article.friendly.find(id)
  end

  def run
    @success = @result.destroy
    self
  end
end
