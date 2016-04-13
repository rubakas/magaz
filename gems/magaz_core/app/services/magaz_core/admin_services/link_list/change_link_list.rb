class MagazCore::AdminServices::LinkList::ChangeLinkList < ActiveInteraction::Base

  string :name, :handle
  integer :id, :shop_id

  validates :id, :shop_id, :name, presence: true

  validate :name_uniqueness, if: :name_changed?

  def execute
    link_list = MagazCore::LinkList.friendly.find(id)
    link_list.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('default.services.wrong_params',
                               model: I18n.t('default.services.link_list')))

    link_list
  end

  private

  def name_changed?
    MagazCore::LinkList.friendly.find(id).name != name
  end

  def name_uniqueness
    errors.add(:base, I18n.t('default.services.not_unique',
                             parameter: I18n.t('default.services.name'))) unless name_unique?
  end

  def name_unique?
    MagazCore::LinkList.where(shop_id: shop_id, name: name).count == 0
  end

end
