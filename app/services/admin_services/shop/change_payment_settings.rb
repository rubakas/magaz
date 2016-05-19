class AdminServices::Shop::ChangePaymentSettings < ActiveInteraction::Base

  string :authorization_settings
  integer :id

  validates :id, :authorization_settings, presence: true

  def execute
    shop = Shop.find(id)
    shop.update_attributes!(shop_params) ||
      errors.add(:base, I18n.t('services.shop_services.wrong_params'))

    shop
  end

  private

  def shop_params
    params = inputs.slice!(:id)
    params[:authorization_settings] = nil unless authorization_method_included?
    params
  end

  def authorization_method_included?
    %w[ authorize_and_charge authorize ].include?(authorization_settings)
  end

end
