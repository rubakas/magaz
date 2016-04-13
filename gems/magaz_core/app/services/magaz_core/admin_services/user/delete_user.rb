class MagazCore::AdminServices::User::DeleteUser < ActiveInteraction::Base

  integer :id

  validates :id, presence: true

  def execute
    MagazCore::User.find(id).destroy
  end

end