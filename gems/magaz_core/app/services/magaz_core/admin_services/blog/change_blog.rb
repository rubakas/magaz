class MagazCore::AdminServices::Blog::ChangeBlog < ActiveInteraction::Base

  string :title, :page_title, :handle, :meta_description
  integer :id, :shop_id

  validates :id, :shop_id, :title, presence: true

  validate :title_uniqueness, if: :title_changed?

  def execute
    blog = MagazCore::Blog.friendly.find(id)
    blog.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('default.services.wrong_params',
                               model: I18n.t('default.services.blog')))

    blog
  end

  private

  def title_changed?
    MagazCore::Blog.friendly.find(id).title != title
  end

  def title_uniqueness
    errors.add(:base, I18n.t('default.services.not_unique',
                             parameter: I18n.t('default.services.title'))) unless title_unique?
  end

  def title_unique?
    MagazCore::Blog.where(shop_id: shop_id, title: title).count == 0
  end

end