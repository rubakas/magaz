class MagazCore::AdminServices::Link::DeleteLink < ActiveInteraction::Base

  integer :id
  string :link_list_id

  validates :id, :link_list_id, presence: true

  def link_list
    MagazCore::LinkList.friendly.find(link_list_id)    
  end

  def execute
    MagazCore::LinkList.friendly.find(link_list_id).links.find(id).destroy
  end

end
