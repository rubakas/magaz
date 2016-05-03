class MagazCore::AdminServices::Shop::ChangePaymentSettings < ActiveInteraction::Base

  AUTHORIZATION_METHOD = %w[ authorize_and_charge authorize ]

  string :authorization_settings
  integer :id

  validates :id, :authorization_settings, presence: true

  def execute
    shop = MagazCore::Shop.find(id)
    shop.update_attributes!(params_for_update) ||
      errors.add(:base, I18n.t('services.shop_services.wrong_params'))

    shop
  end

  private

  def params_for_update
    params = inputs.slice!(:id)
    params[:authorization_settings] = nil unless authorization_method_included?
    params
  end

  def authorization_method_included?
    AUTHORIZATION_METHOD.include?(authorization_settings)
  end

end