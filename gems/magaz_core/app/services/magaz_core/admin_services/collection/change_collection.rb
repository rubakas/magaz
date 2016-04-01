class MagazCore::AdminServices::Collection::ChangeCollection < ActiveInteraction::Base

  string :name, :page_title, :handle, :meta_description, :description
  integer :id, :shop_id

  validates :id, :shop_id, :name, presence: true

  validate :name_uniqueness, if: :name_changed?

  def execute
    collection = MagazCore::Collection.friendly.find(id)
    collection.update_attributes!(inputs.slice!(:collection)) ||
      errors.add(:base, "Wrong params for collection")

    collection
  end

  private

  def name_changed?
    MagazCore::Collection.friendly.find(id).name != name
  end

  def name_uniqueness
    errors.add(:base, "Name has already been taken") unless name_unique?
  end

  def name_unique?
    MagazCore::Collection.where(shop_id: shop_id, name: name).count == 0
  end

end
