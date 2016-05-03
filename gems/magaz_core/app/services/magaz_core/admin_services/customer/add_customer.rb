class MagazCore::AdminServices::Customer::AddCustomer < ActiveInteraction::Base

  set_callback :validate, :after, -> {customer}

  string :first_name, :last_name, :email
  integer :shop_id

  validates :email, :shop_id, presence: true
  validate :customer_uniquness

  def customer
    @customer = MagazCore::Shop.find(shop_id).customers.new
    add_errors if errors.any?
    @customer
  end

  def execute
    unless @customer.update_attributes(inputs)
      errors.merge!(@customer.errors)
    end
    @customer
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @customer.errors.add(:base, msg)
    end
  end
  
  def customer_uniquness
    errors.add(:base, I18n
                .t('services.add_customer.customer_exist')) unless customer_unique?
  end

  def customer_unique?
    MagazCore::Customer.where(shop_id: shop_id, email: email).count == 0
  end

end
