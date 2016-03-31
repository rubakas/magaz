class MagazCore::ShopServices::Blog::DeleteBlog < ActiveInteraction::Base

  integer :id

  validates :id, presence: true

  def execute
    MagazCore::Blog.friendly.find(id).destroy
  end

end