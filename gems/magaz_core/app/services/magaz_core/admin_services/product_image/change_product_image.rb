class MagazCore::AdminServices::ProductImage::ChangeProductImage < ActiveInteraction::Base

  file    :image
  integer :id

  def execute

    product_image = MagazCore::ProductImage.find(id)
    product_image.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('default.services.change_product_image.wrong_params'))

    product_image
  end
end