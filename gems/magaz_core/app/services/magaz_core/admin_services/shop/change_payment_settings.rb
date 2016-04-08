class MagazCore::AdminServices::Shop::ChangePaymentSettings < ActiveInteraction::Base

  AUTHORIZATION_METHOD = %w[ authorize_and_charge authorize ]

  string :authorization_settings
  integer :id

  validates :id, :authorization_settings, presence: true

  validate :authorization_method_included?

  def execute
    params = inputs.slice!(:id)
    shop = MagazCore::Shop.find(id)
    params[:authorization_settings] = nil unless authorization_method_included?

    shop.update_attributes!(params) ||
      errors.add(:base, I18n.t('default.services.change_payments.wrong_params'))

    shop
  end

  private

  def authorization_method_included?
    AUTHORIZATION_METHOD.include?(authorization_settings)
  end

end