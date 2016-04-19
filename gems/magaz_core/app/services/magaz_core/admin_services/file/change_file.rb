class MagazCore::AdminServices::File::ChangeFile < ActiveInteraction::Base

  file :file
  integer :id, :shop_id
  string :name

  validates :id, :file, :shop_id, :name, presence: true

  def execute
    file = MagazCore::Shop.find_by_id(shop_id).files.find(id)

    unless file.update_attributes(inputs.slice!(:id))
      errors.merge!(file.errors)
    end

    file
  end
end