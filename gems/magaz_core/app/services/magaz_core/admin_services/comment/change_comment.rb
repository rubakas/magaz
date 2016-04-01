class MagazCore::AdminServices::Comment::ChangeComment < ActiveInteraction::Base

  string :author, :email, :body
  integer :id

  validates :author, :email, :body, :id, presence: true

  def execute
    comment = MagazCore::Comment.find(id)
    comment.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('default.services.change_comment.wrong_params'))

    comment
  end
end
