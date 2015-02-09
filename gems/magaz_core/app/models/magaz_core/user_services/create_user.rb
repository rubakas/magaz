module MagazCore
  module UserServices
    class CreateUser
      include MagazCore::Concerns::Service
      attr_accessor :user

      def call(user_params: {}, shop:)
        @user = shop.users.new

        MagazCore::User.connection.transaction do
          begin
            _save_user_record!(user: @user, params: user_params)

          rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid
            raise ActiveRecord::Rollback
          end
        end
      end

      private

      def _save_user_record!(user:, params:)
        user.attributes = params
        user.update_attributes(account_owner: true)
        user.save!
        _send_confirmation(user: user)
      end

      def _send_confirmation(user:)
        MagazCore::UserMailer.registration_confirmation(user).deliver
      end
    end
  end
end