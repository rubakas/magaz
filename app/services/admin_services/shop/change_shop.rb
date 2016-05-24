class AdminServices::Shop::ChangeShop < ActiveInteraction::Base

  set_callback :validate, :after, -> {shop}

  string :name

  string :address, :business_name, :city, :country,
         :meta_description, :currency, :phone, :timezone,
         :unit_system, :zip, :page_title, default: nil

  string :customer_email, default: nil

  integer :id

  validates :id, :name, presence: true
  validates :country, inclusion: YAML.load_file("#{Rails.root}/config/countries.yml")['countries'].keys
  validates :unit_system, inclusion: %w[ metric imperial]
  validates :currency, inclusion: %w[ USD EURO HRN]
  #TODO .zones_map method is private now
  validates :timezone, inclusion: ActiveSupport::TimeZone.send(:zones_map).values.collect{|z| z.name}

  validate :check_customer_email
  validate :name_uniqueness, if: :name_changed?

  def shop
    @shop = Shop.find(id)
    add_errors if errors.any?
    @shop
  end

  def execute
    @shop.update_attributes(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.shop_services.wrong_params'))

    @shop
  end

  private

  def check_customer_email
    errors.add(:base, I18n.t('services.change_shop.email_not_valid')) unless email_valid?
  end

  def email_valid?
    if customer_email.present?
      customer_email =~
      Concerns::PasswordAuthenticable::EMAIL_VALID_REGEX
    else
      true
    end
  end

  def add_errors
    errors.full_messages.each do |msg|
      @shop.errors.add(:base, msg)
    end
  end

  def name_changed?
    ::Shop.find(id).name != name
  end

  def name_uniqueness
    errors.add(:base, I18n.t('services.change_shop.name_not_unique')) unless name_unique?
  end

  def name_unique?
    ::Shop.where.not(id: id).where(name: name).count == 0
  end

end
