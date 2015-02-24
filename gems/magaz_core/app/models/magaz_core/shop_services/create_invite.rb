module MagazCore
  module ShopServices
    class CreateInvite
      include MagazCore::Concerns::Service
      attr_accessor :user
      attr_accessor :shop

      def call(email:, shop:)
        @user = MagazCore::User.new

        MagazCore::User.connection.transaction do
          begin
            _valid_email(email: email, shop: shop)
            _create_user_with_email_and_token!(user: @user, email: email, shop_id: shop.id)
          rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid
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
          shop.users.find_by(email: email).nil? || fail(ActiveRecord::RecordNotFound)
      end
    end
  end
end