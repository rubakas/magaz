class MagazCore::AdminServices::EmailTemplate::ChangeEmailTemplate < ActiveInteraction::Base

  integer :id, :shop_id
  string :title, :body

  def execute
    email_template = MagazCore::EmailTemplate.find(id)
    email_template.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('default.services.wrong_params',
                               model: I18n.t('default.services.email_template')))

    email_template
  end
end
