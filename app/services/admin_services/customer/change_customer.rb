class AdminServices::Customer::ChangeCustomer < ActiveInteraction::Base

  set_callback :validate, :after, -> {customer}

  string :first_name, :last_name, :email
  integer :id, :shop_id

  validates :id, :shop_id, :email, presence: true
  validate :customer_uniqueness, if: :email_changed?

  def customer
    @customer = Shop.find(shop_id).customers.find(id)
    add_errors if errors.any?
    @customer
  end

  def execute
    @customer.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.change_customer.wrong_params'))
    @customer
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @customer.errors.add(:base, msg)
    end
  end

  def email_changed?
    Shop.find(shop_id).customers.find(id).email != email
  end

  def customer_uniqueness
    errors.add(:base, I18n
                .t('services.change_customer.customer_exist')) unless customer_unique?
  end

  def customer_unique?
    ::Customer.where.not(id: id).where(shop_id: shop_id, email: email).count == 0
  end
end
