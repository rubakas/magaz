class MagazCore::AdminServices::Shop::ChangeDefaultCollection < ActiveInteraction::Base

  integer :id, :collection_id

  validates :id, :collection_id, presence: true

  validate :collection_exists?

  def execute
    shop = MagazCore::Shop.find(id)

    shop.update_attributes(eu_digital_goods_collection_id: collection_id) ||
      errors.add(:base, I18n.t('services.shop_services.wrong_params'))

    shop
  end

  private

  def collection_exists?
    MagazCore::Collection.where(shop_id: id, id: collection_id).present?
  end

end
