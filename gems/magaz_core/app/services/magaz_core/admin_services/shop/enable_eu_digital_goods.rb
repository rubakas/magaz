class MagazCore::AdminServices::Shop::EnableEuDigitalGoods < ActiveInteraction::Base

  string :collection_name
  integer :id

  validates :id, :collection_name, presence: true

  def execute
    @shop = MagazCore::Shop.find(id)

    if default_collection_exists?
      default_collection = @shop.collections.find_by(name: collection_name)
    else
      default_collection =  @shop.collections.create(name: collection_name)
    end

    @shop.update_attributes(eu_digital_goods_collection_id: default_collection.id) ||
      errors.add(:base, I18n.t('services.shop_services.wrong_params'))

    @shop
  end

  private

  def default_collection_exists?
    @shop.collections.find_by(name: collection_name).present?
  end

end
