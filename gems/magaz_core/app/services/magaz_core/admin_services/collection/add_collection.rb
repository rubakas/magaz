class MagazCore::AdminServices::Collection::AddCollection < ActiveInteraction::Base

  string :name, :description, :page_title, :meta_description, :handle
  integer :shop_id

  validates :name, :shop_id, presence: true

  validate :name_uniqueness

  def to_model
    MagazCore::Collection.new
  end

  def execute
    collection = MagazCore::Collection.new(inputs)

    unless collection.save
      errors.merge!(collection.errors)
    end

    collection
  end

  private

  def name_uniqueness
    errors.add(:base, I18n.t('default.services.not_unique',
                             parameter: I18n.t('default.services.name'))) unless name_unique?
  end

  def name_unique?
    MagazCore::Collection.where(shop_id: shop_id, name: name).count == 0
  end
end
