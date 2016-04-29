class MagazCore::AdminServices::Blog::AddBlog < ActiveInteraction::Base

  set_callback :validate, :after, -> {blog}

  string :title, :page_title, :meta_description, :handle
  integer :shop_id

  validates :title, :shop_id, presence: true
  validate :title_uniqueness, :handle_uniqueness

  def blog
    @object = MagazCore::Blog.new
    add_errors if errors.any?
    @object
  end

  def execute
    blog = MagazCore::Blog.new(inputs)
    unless blog.save
      errors.merge!(blog.errors)
    end
    blog
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @object.errors.add(:base, msg)
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
    if handle =~ /^-?[1-9]\d*$/
      MagazCore::Blog.where(shop_id: shop_id, handle: handle).count == 0 &&
                          MagazCore::Blog.where(shop_id: shop_id, id: handle.to_i.abs).count == 0
    else
      MagazCore::Blog.where(shop_id: shop_id, handle: handle).count == 0
    end
  end

end
