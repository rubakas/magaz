class AdminServices::Page::ChangePage < ActiveInteraction::Base

  set_callback :validate, :after, -> {page}

  string :id, :title, :content, :page_title, :meta_description, :handle
  integer :shop_id

  validates :id, :shop_id, :title, presence: true
  validate :title_uniqueness, if: :title_changed?
  validate :handle_uniqueness, if: :handle_changed?

  def page
    @page = Shop.find(shop_id).pages.friendly.find(id)
    add_errors if errors.any?
    @page
  end

  def execute
    @page.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.change_page.wrong_params'))
    @page
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @page.errors.add(:base, msg)
    end
  end

  def title_changed?
    ::Page.friendly.find(id).title != title
  end

  def title_uniqueness
    errors.add(:base, I18n.t('services.change_page.title_not_unique')) unless title_unique?
  end

  def title_unique?
    ::Page.where(shop_id: shop_id, title: title).count == 0
  end

  def handle_changed?
    Shop.find(shop_id).pages.friendly.find(id).handle != handle
  end

  def handle_uniqueness
    unless handle.empty?
      errors.add(:base, I18n.t('services.change_page.handle_not_unique')) unless handle_unique?
    end
  end

  def handle_unique?
    ::Page.where(shop_id: shop_id, handle: handle).count == 0
  end

end
