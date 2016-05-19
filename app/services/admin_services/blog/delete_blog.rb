class AdminServices::Blog::DeleteBlog < ActiveInteraction::Base

  string :id
  integer :shop_id

  validates :id, :shop_id, presence: true

  def execute
    ::Shop.find(shop_id).blogs.friendly.find(id).destroy
  end

end
