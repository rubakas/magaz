module MagazCore
  module ShopServices
    class CreateInvite
      include MagazCore::Concerns::Service
      include Rails.application.routes.url_helpers
      attr_accessor :user
      attr_accessor :shop

      def call
        @user = MagazCore::User.new
      end

      def create_user_with_email_and_token!(user: @user, email:, shop:)
        user.update_attributes(email: email, shop_id: shop.id)
        user.invite_token = Digest::SHA1.hexdigest([user.id, Time.now, rand].join)
        user.save!(validate: false)
      end

      def valid_email(email:, shop:)
        valid_email = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
        email.present? &&
          (email =~ valid_email) &&
          shop.users.find_by(email: email).nil?
      end

      def send_mail_invite(user:, link:)
        MagazCore::UserMailer.invite_new_user(user,
                                             link).deliver_now || fail(ArgumentError)
      end
    end
  end
end