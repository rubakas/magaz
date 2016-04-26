class MagazCore::AdminServices::Blog::DeleteBlog < ActiveInteraction::Base

  string :id

  validates :id, presence: true

  def execute
    MagazCore::Blog.friendly.find(id).destroy
  end

end