class AdminServices::Page::AddPage < ActiveInteraction::Base

  set_callback :validate, :after, -> {page}

  string :title, :content, :page_title, :meta_description, :handle
  integer :shop_id

  validates :title, :shop_id, presence: true
  validate :title_uniqueness, :handle_uniqueness

  def page
    @page = Shop.find(shop_id).pages.new
    add_errors if errors.any?
    @page
  end

  def execute
    unless @page.update_attributes(inputs)
      errors.merge!(@page.errors)
    end
    @page
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @page.errors.add(:base, msg)
    end
  end

  def title_uniqueness
    errors.add(:base, I18n.t('services.add_page.title_not_unique')) unless title_unique?
  end

  def title_unique?
    ::Page.where(shop_id: shop_id, title: title).count == 0
  end

  def handle_uniqueness
    unless handle.empty?
      errors.add(:base, I18n.t('services.add_page.handle_not_unique')) unless handle_unique?
    end
  end

  def handle_unique?
    ::Page.where(shop_id: shop_id, handle: handle).count == 0
  end

end
