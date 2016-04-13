class MagazCore::AdminServices::Checkout::ChangeOrder < ActiveInteraction::Base

  string :status
  integer :id

  validates :id, :status, presence: true

  def execute
    order = MagazCore::Checkout.find(id)
    order.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('default.services.wrong_params',
                               model: I18n.t('default.services.order')))

    order
  end

end