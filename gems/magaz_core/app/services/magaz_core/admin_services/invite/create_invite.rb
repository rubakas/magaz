class MagazCore::AdminServices::Invite::CreateInvite < ActiveInteraction::Base

  string :email
  string :link, default: nil
  integer :shop_id
  interface :url_building_proc, methods: [:call]

  validates :email, :shop_id, presence: true
  validate :check_email

  def execute
    @user = MagazCore::User.new

    MagazCore::User.connection.transaction do
      begin
        create_user_with_email_and_token
        generate_link_for_user
        send_mail_invite
      rescue RuntimeError
        raise ActiveRecord::Rollback
      end
    end
  end

  private

  def generate_link_for_user
    self.link = url_building_proc.call(@user)
  end

  def create_user_with_email_and_token
    @user.update_attributes(email: email, shop_id: shop_id)
    @user.invite_token = Digest::SHA1.hexdigest([@user.id, Time.now, rand].join)
    @user.save!(validate: false)
  end

  def check_email
    errors.add(:base, I18n.t('services.create_invite.email_not_valid')) unless email_valid?
    errors.add(:base, I18n.t('services.create_invite.email_not_unique')) unless email_unique?
  end

  def email_unique?
    MagazCore::Shop.find_by_id(shop_id).users.find_by(email: email).nil?
  end

  def email_valid?
    email && email =~ MagazCore::Concerns::PasswordAuthenticable::EMAIL_VALID_REGEX
  end

  def send_mail_invite
    MagazCore::UserMailer.invite_new_user(@user, link).deliver_now || fail
  end
end
