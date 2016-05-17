class AdminServices::LinkList::ChangeLinkList < ActiveInteraction::Base

  set_callback :validate, :after, -> {link_list}

  string :id, :name, :handle
  integer :shop_id

  validates :id, :shop_id, :name, presence: true
  validate :name_uniqueness, if: :name_changed?
  validate :handle_uniqueness, if: :handle_changed?

  def link_list
    @link_list = Shop.find(shop_id).link_lists.friendly.find(id)
    add_errors if errors.any?
    @link_list
  end

  def execute
    @link_list.update_attributes(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.change_link_list.wrong_params'))
    @link_list
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @link_list.errors.add(:base, msg)
    end
  end

  def name_changed?
    Shop.find(shop_id).link_lists.friendly.find(id).name != name
  end

  def name_uniqueness
    errors.add(:base, I18n.t('services.change_link_list.name_not_unique')) unless name_unique?
  end

  def name_unique?
    ::LinkList.where(shop_id: shop_id, name: name).count == 0
  end

  def handle_changed?
    Shop.find(shop_id).link_lists.friendly.find(id).handle != handle
  end

  def handle_uniqueness
    unless handle.empty?
      errors.add(:base, I18n.t('services.change_link_list.handle_not_unique')) unless handle_unique?
    end
  end

  def handle_unique?
    ::LinkList.where(shop_id: shop_id, handle: handle).count == 0
  end

end
