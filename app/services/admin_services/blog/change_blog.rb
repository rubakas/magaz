class AdminServices::Blog::ChangeBlog < ActiveInteraction::Base

  set_callback :validate, :after, -> {blog}

  string :id, :title, :page_title, :handle, :meta_description
  integer :shop_id

  validates :id, :shop_id, :title, presence: true
  validate :title_uniqueness, if: :title_changed?
  validate :handle_uniqueness, if: :handle_changed?

  def blog
    @blog = Shop.find(shop_id).blogs.friendly.find(id)
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
    Shop.find(shop_id).blogs.friendly.find(id).title != title
  end

  def title_uniqueness
    errors.add(:base, I18n.t('services.change_blog.title_not_unique')) unless title_unique?
  end

  def title_unique?
    Blog.where(shop_id: shop_id, title: title).count == 0
  end

  def handle_changed?
    Shop.find(shop_id).blogs.friendly.find(id).handle != handle
  end

  def handle_uniqueness
    unless handle.empty?
      errors.add(:base, I18n.t('services.change_blog.handle_not_unique')) unless handle_unique?
    end
  end

  def handle_unique?
    Blog.where(shop_id: shop_id, handle: handle).count == 0
  end

end
