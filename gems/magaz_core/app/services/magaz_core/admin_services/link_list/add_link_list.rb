class MagazCore::AdminServices::LinkList::AddLinkList < ActiveInteraction::Base

  set_callback :validate, :after, -> {link_list}

  string :name, :handle
  integer :shop_id

  validates :name, :shop_id, presence: true
  validate :name_uniqueness, :handle_uniqueness

  def link_list
    @link_list = MagazCore::Shop.find(shop_id).link_lists.new
    add_errors if errors.any?
    @link_list
  end

  def execute
    unless @link_list.update_attributes(inputs)
      errors.merge!(@link_list.errors)
    end
    @link_list
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @link_list.errors.add(:base, msg)
    end
  end

  def name_uniqueness
    errors.add(:base, I18n.t('services.add_link_list.name_not_unique')) unless name_unique?
  end

  def name_unique?
    MagazCore::LinkList.where(shop_id: shop_id, name: name).count == 0
  end

  def handle_uniqueness
    unless handle.empty?
      errors.add(:base, I18n.t('services.add_link_list.handle_not_unique')) unless handle_unique?
    end
  end

  def handle_unique?
    MagazCore::LinkList.where(shop_id: shop_id, handle: handle).count == 0
  end

end
