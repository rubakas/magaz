class MagazCore::AdminServices::Collection::ChangeCollection < ActiveInteraction::Base

  string :name, :page_title, :handle, :meta_description, :description
  integer :id, :shop_id

  validates :id, :shop_id, :name, presence: true

  validate :name_uniqueness, if: :name_changed?

  def execute
    collection = MagazCore::Collection.friendly.find(id)
    collection.update_attributes!(inputs.slice!(:collection)) ||
      errors.add(:base, I18n.t('default.services.wrong_params',
                               model: I18n.t('default.services.collection')))

    collection
  end

  private

  def name_changed?
    MagazCore::Collection.friendly.find(id).name != name
  end

  def name_uniqueness
    errors.add(:base, I18n.t('default.services.not_unique',
                             parameter: I18n.t('default.services.name'))) unless name_unique?
  end

  def name_unique?
    MagazCore::Collection.where(shop_id: shop_id, name: name).count == 0
  end

end
