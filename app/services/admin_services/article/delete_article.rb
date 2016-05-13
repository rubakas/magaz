class MagazCore::AdminServices::Article::DeleteArticle < ActiveInteraction::Base

  string :id

  validates :id, presence: true

  def execute
    MagazCore::Article.friendly.find(id).destroy
  end

end