class MagazCore::AdminServices::Article::DeleteArticle < ActiveInteraction::Base

  integer :id

  validates :id, presence: true

  def execute
    MagazCore::Article.friendly.find(id).destroy
  end

end