class MagazCore::AdminServices::Collection::ChangeCollection < ActiveInteraction::Base

  string :id, :name, :page_title, :handle, :meta_description, :description
  integer :shop_id

  validates :id, :shop_id, :name, presence: true

  validate :name_uniqueness, if: :name_changed?
  validate :handle_uniqueness, if: :handle_changed?

  def to_model
    MagazCore::Collection.friendly.find(id)
  end

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

  def handle_changed?
    MagazCore::Collection.friendly.find(id).handle != handle
  end

  def handle_uniqueness
    unless handle.empty?
      errors.add(:base, I18n.t('services.change_collection.handle_not_unique')) unless handle_unique?
    end
  end

  def handle_unique?
    MagazCore::Collection.where(shop_id: shop_id, handle: handle).count == 0
  end
end
