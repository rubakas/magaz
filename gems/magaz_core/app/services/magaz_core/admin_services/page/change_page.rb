class MagazCore::AdminServices::Page::ChangePage < ActiveInteraction::Base

  string :title, :content, :page_title, :meta_description, :handle
  integer :id, :shop_id

  validates :id, :shop_id, :title, presence: true

  validate :title_uniqueness, if: :title_changed?

  def execute
    page = MagazCore::Page.friendly.find(id)
    page.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('default.services.wrong_params',
                               model: I18n.t('default.services.page')))

    page
  end

  private

  def title_changed?
    MagazCore::Page.friendly.find(id).title != title
  end

  def title_uniqueness
    errors.add(:base, I18n.t('default.services.not_unique',
                             parameter: I18n.t('default.services.title'))) unless title_unique?
  end

  def title_unique?
    MagazCore::Page.where(shop_id: shop_id, title: title).count == 0
  end

end
