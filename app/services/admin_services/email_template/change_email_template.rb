class AdminServices::EmailTemplate::ChangeEmailTemplate < ActiveInteraction::Base

  integer :id, :shop_id
  string :title, :body

  def execute
    email_template = EmailTemplate.find(id)
    email_template.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.change_email_template.wrong_params'))

    email_template
  end
end
