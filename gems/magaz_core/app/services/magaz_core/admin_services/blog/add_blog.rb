class MagazCore::AdminServices::Blog::AddBlog < ActiveInteraction::Base

  set_callback :validate, :after, -> {blog}

  string :title, :page_title, :meta_description, :handle
  integer :shop_id

  validates :title, :shop_id, presence: true
  validate :title_uniqueness, :handle_uniqueness

  def blog
    @blog = MagazCore::Shop.find(shop_id).blogs.new
    add_errors if errors.any?
    @blog
  end

  def execute
    unless @blog.update_attributes(inputs)
      errors.merge!(@blog.errors)
    end
    @blog
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @blog.errors.add(:base, msg)
    end
  end

  def title_uniqueness
    errors.add(:base, I18n.t('services.add_blog.title_not_unique')) unless title_unique?
  end

  def title_unique?
    MagazCore::Blog.where(shop_id: shop_id, title: title).count == 0
  end

  def handle_uniqueness
    unless handle.empty?
      errors.add(:base, I18n.t('services.add_blog.handle_not_unique')) unless handle_unique?
    end
  end

  def handle_unique?
    MagazCore::Blog.where(shop_id: shop_id, handle: handle).count == 0
  end

end
