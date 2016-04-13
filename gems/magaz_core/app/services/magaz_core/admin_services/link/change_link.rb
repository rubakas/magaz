class MagazCore::AdminServices::Link::ChangeLink < ActiveInteraction::Base

  string :name, :link_type
  integer :id, :link_list_id, :position

  validates :id, :link_list_id, :name, presence: true

  validate :name_uniqueness, if: :name_changed?

  def execute
    link = MagazCore::LinkList.friendly.find(link_list_id).links.find(id)
    link.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('default.services.wrong_params',
                               model: I18n.t('default.services.link')))

    link
  end

  private

  def name_changed?
    MagazCore::LinkList.friendly.find(link_list_id).links.find(id).name != name
  end

  def name_uniqueness
    errors.add(:base, I18n.t('default.services.not_unique',
                             parameter: I18n.t('default.services.name'))) unless name_unique?
  end

  def name_unique?
    MagazCore::Link.where(link_list_id: link_list_id, name: name).count == 0
  end

end
