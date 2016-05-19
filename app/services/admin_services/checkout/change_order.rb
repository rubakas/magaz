class AdminServices::Checkout::ChangeOrder < ActiveInteraction::Base

  set_callback :validate, :after, -> {order}

  string :status
  integer :id

  validates :id, :status, presence: true

  def order
    @order = Checkout.find(id)
    add_errors if errors.any?
    @order
  end

  def execute
    @order.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.change_order.wrong_params'))

    @order
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @order.errors.add(:base, msg)
    end
  end
end
