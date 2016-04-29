class MagazCore::AdminServices::Blog::ChangeBlog < ActiveInteraction::Base

  set_callback :validate, :after, -> {object}

  string :id, :title, :page_title, :handle, :meta_description
  integer :shop_id

  validates :id, :shop_id, :title, presence: true
  validate :title_uniqueness, if: :title_changed?
  validate :handle_uniqueness, if: :handle_changed?

  def object
    @blog = MagazCore::Shop.find(shop_id).blogs.friendly.find(id)
    add_errors if errors.any?
    @blog
  end

  def execute
    @blog.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.change_blog.wrong_params'))

    @blog
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @blog.errors.add(:base, msg)
    end
  end

  def title_changed?
    MagazCore::Blog.friendly.find(id).title != title
  end

  def title_uniqueness
    errors.add(:base, I18n.t('services.change_blog.title_not_unique')) unless title_unique?
  end

  def title_unique?
    MagazCore::Blog.where(shop_id: shop_id, title: title).count == 0
  end

  def handle_changed?
    MagazCore::Blog.friendly.find(id).handle != handle
  end

  def handle_uniqueness
    unless handle.empty?
      errors.add(:base, I18n.t('services.change_blog.handle_not_unique')) unless handle_unique?
    end
  end

  def handle_unique?
    if handle =~ /^-?[1-9]\d*$/
      MagazCore::Blog.where(shop_id: shop_id, handle: handle).count == 0 &&
                          MagazCore::Blog.where(shop_id: shop_id, id: handle.to_i.abs).count == 0
    else
      MagazCore::Blog.where(shop_id: shop_id, handle: handle).count == 0
    end
  end
end