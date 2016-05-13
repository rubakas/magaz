class AdminServices::Collection::ChangeCollection < ActiveInteraction::Base

  set_callback :validate, :after, -> {collection}

  string :id, :name, :page_title, :handle, :meta_description, :description
  integer :shop_id

  validates :id, :shop_id, :name, presence: true

  validate :name_uniqueness, if: :name_changed?
  validate :handle_uniqueness, if: :handle_changed?

  def collection
    @collection = Shop.find(shop_id).collections.friendly.find(id)
    add_errors if errors.any?
    @collection
  end

  def execute
    @collection.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.change_collection.wrong_params'))

    @collection
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @collection.errors.add(:base, msg)
    end
  end

  def handle_uniqueness
    unless handle.empty?
      errors.add(:base,
                 I18n.t('services.change_collection.handle_not_unique')) unless handle_unique?
    end
  end

  def handle_changed?
    Collection.friendly.find(id).handle != handle
  end


  def handle_unique?
    Collection.where(shop_id: shop_id, handle: handle).count == 0
  end

  def name_changed?
    Collection.friendly.find(id).name != name
  end

  def name_uniqueness
    errors.add(:base, "Name has already been taken") unless name_unique?
  end

  def name_unique?
    Collection.where(shop_id: shop_id, name: name).count == 0
  end

end
