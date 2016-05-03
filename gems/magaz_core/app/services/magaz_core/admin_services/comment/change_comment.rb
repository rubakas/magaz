class MagazCore::AdminServices::Comment::ChangeComment < ActiveInteraction::Base

  set_callback :validate, :after, -> {comment}

  string :author, :email, :body
  integer :id

  validates :author, :email, :body, :id, presence: true
  validate :check_email

  def comment
    @comment = MagazCore::Comment.find(id)
    add_errors if errors.any?
    @comment
  end

  def execute
    @comment.update_attributes(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.change_comment.wrong_params'))

    @comment
  end

  private

  def check_email
    errors.add(:base, I18n.t('services.change_comment.email_not_valid')) unless email_valid?
  end

  def email_valid?
    email && email =~ MagazCore::Concerns::PasswordAuthenticable::EMAIL_VALID_REGEX
  end

  def add_errors
    errors.full_messages.each do |msg|
      @comment.errors.add(:base, msg)
    end
  end
end
