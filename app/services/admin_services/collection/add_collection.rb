class AdminServices::Collection::AddCollection < ActiveInteraction::Base

  set_callback :validate, :after, -> {collection}

  string :name, :description, :page_title, :meta_description, :handle
  integer :shop_id

  validates :name, :shop_id, presence: true

  validate :name_uniqueness
  validate :handle_uniqueness

  def collection
    @collection = Shop.find(shop_id).collections.new
    add_errors if errors.any?
    @collection
  end

  def execute
    unless @collection.update_attributes(inputs)
      errors.merge!(@collection.errors)
    end

    @collection
  end

  private

  def handle_uniqueness
    unless handle.empty?
      errors.add(:base,
                 I18n.t('services.add_collection.handle_not_unique')) unless handle_unique?
    end
  end

  def handle_unique?
    Collection.where(shop_id: shop_id, handle: handle).count == 0
  end

  def add_errors
    errors.full_messages.each do |msg|
      @collection.errors.add(:base, msg)
    end
  end

  def name_uniqueness
    errors.add(:base, I18n.t('services.add_collection.name_not_unique')) unless name_unique?
  end

  def name_unique?
    Collection.where(shop_id: shop_id, name: name).count == 0
  end
end
