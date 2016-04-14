class MagazCore::AdminServices::LinkList::ChangeLinkList < ActiveInteraction::Base

  string :name, :handle
  integer :id, :shop_id

  validates :id, :shop_id, :name, presence: true

  validate :name_uniqueness, if: :name_changed?

  def execute
    link_list = MagazCore::LinkList.friendly.find(id)
    link_list.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.change_link_list.wrong_params'))

    link_list
  end

  private

  def name_changed?
    MagazCore::LinkList.friendly.find(id).name != name
  end

  def name_uniqueness
    errors.add(:base, I18n.t('services.change_link_list.name_not_unique')) unless name_unique?
  end

  def name_unique?
    MagazCore::LinkList.where(shop_id: shop_id, name: name).count == 0
  end

end
