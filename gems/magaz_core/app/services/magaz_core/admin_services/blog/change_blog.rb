class MagazCore::AdminServices::Blog::ChangeBlog < ActiveInteraction::Base

  string :title, :page_title, :handle, :meta_description
  integer :id, :shop_id

  validates :id, :shop_id, :title, presence: true

  validate :title_uniqueness, if: :title_changed?

  def execute
    blog = MagazCore::Blog.friendly.find(id)
    blog.update_attributes!(inputs.slice!(:blog)) ||
      errors.add(:base, I18n.t('default.services.change_blog.wrong_params'))

    blog
  end

  private

  def title_changed?
    MagazCore::Blog.friendly.find(id).title != title
  end

  def title_uniqueness
    errors.add(:base, I18n.t('default.services.change_blog.title_not_unique')) unless title_unique?
  end

  def title_unique?
    MagazCore::Blog.where(shop_id: shop_id, title: title).count == 0
  end

end