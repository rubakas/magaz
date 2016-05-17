class AdminServices::Article::DeleteArticle < ActiveInteraction::Base

  string :id

  validates :id, presence: true

  def execute
    ::Article.friendly.find(id).destroy
  end

end
