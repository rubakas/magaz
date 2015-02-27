module MagazCore
  module ShopServices
    class CreateInvite
      include MagazCore::Concerns::Service
      include Rails.application.routes.url_helpers
      attr_accessor :user
      attr_accessor :shop

      def call(email:, shop:, host:)
        @user = MagazCore::User.new

        MagazCore::User.connection.transaction do
          begin
            _valid_email(email: email, shop: shop)
            _create_user_with_email_and_token!(user: @user, email: email, shop_id: shop.id)
            _send_mail_invite(user: @user, email: email, host: host )
          rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, ArgumentError
            raise ActiveRecord::Rollback
          end
        end
      end

      private

      def _create_user_with_email_and_token!(user:, email:, shop_id:)
        user.update_attributes(email: email,shop_id: shop_id)
        user.invite_token = Digest::SHA1.hexdigest([user.id, Time.now, rand].join)
        user.save!(validate: false)
      end

      def _valid_email(email:, shop:)
        valid_email = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
        email.present? &&
          (email =~ valid_email) &&
          shop.users.find_by(email: email).nil? || fail(ArgumentError)
      end

      def _send_mail_invite(user:, email:, host:)
        MagazCore::UserMailer.invite_new_user(user,
                              admin_user_url(user, host: host, invite_token: user.invite_token),
                              host).deliver_now || fail(ArgumentError)
      end
    end
  end
end