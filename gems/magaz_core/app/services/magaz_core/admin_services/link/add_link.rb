class MagazCore::AdminServices::Link::AddLink < ActiveInteraction::Base

  set_callback :validate, :after, -> {link}

  string :name, :link_list_id, :link_type, :position

  validates :name, :link_list_id, presence: true
  validate :name_uniqueness

  def link
    @link_list = MagazCore::LinkList.friendly.find(link_list_id)
    @link = @link_list.links.new
    add_errors if errors.any?
    @link
  end

  def execute
    unless @link.update_attributes(inputs.slice!(:link_list_id))
      errors.merge!(@link.errors)
    end
    @link
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @link.errors.add(:base, msg)
    end
  end

  def name_uniqueness
    errors.add(:base, I18n.t('services.add_link.name_not_unique')) unless name_unique?
  end

  def name_unique?
    MagazCore::Link.where(link_list_id: link_list_id, name: name).count == 0
  end

end
