class ThemeServices::CreatePartner < ActiveInteraction::Base

  set_callback :validate, :after, -> {partner}
  
  string :name, :website_url

  validates :name, presence: true
  validates :website_url, presence: true,
              format: { with: /(https?:\/\/(?:www\.|(?!www))[^\s\.]+\.[^\s]{2,}|www\.[^\s]+\.[^\s]{2,})/ }
  validate :name_uniqueness, :website_uniqueness

  def partner
    @partner = Partner.new
    add_errors if errors.any?
    @partner
  end
    
  def execute
    unless @partner.update_attributes(inputs)
      errors.merge!(@partner.errors)
    end
    @partner  
  end

  private
  
  def add_errors
    errors.full_messages.each do |msg|
      @partner.errors.add(:base, msg)
    end    
  end 

  def name_uniqueness
    errors.add(:base, I18n.t('services.create_partner.name_not_unique')) unless name_unique?
  end

  def name_unique?
    Partner.where(name: name).count == 0
  end

  def website_uniqueness
    errors.add(:base, I18n.t('services.create_partner.website_not_unique')) unless website_unique?
  end

  def website_unique?
    Partner.where(website_url: website_url).count == 0
  end

end
