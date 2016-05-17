class AdminServices::Link::ChangeLink < ActiveInteraction::Base

  set_callback :validate, :after, -> {link}

  string :name, :link_list_id, :link_type, :position
  integer :id

  validates :id, :link_list_id, :name, presence: true
  validate :name_uniqueness, if: :name_changed?

  def link
    link_list = LinkList.friendly.find(link_list_id)
    @link = link_list.links.find(id)
    add_errors if errors.any?
    @link
  end

  def execute
    @link.update_attributes!(inputs.slice!(:id, :link_list_id)) ||
      errors.add(:base, I18n.t('services.change_link.wrong_params'))
    @link
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @link.errors.add(:base, msg)
    end
  end

  def name_changed?
    LinkList.friendly.find(link_list_id).links.find(id).name != name
  end

  def name_uniqueness
    errors.add(:base, I18n.t('services.change_link.name_not_unique')) unless name_unique?
  end

  def name_unique?
    ::Link.where(link_list_id: link_list_id, name: name).count == 0
  end

end
