module MagazCore
  module ShopServices
    class CreateUser
      include MagazCore::Concerns::Service
      attr_accessor :shop

      def call(shop_id:, params: {})
        @shop = MagazCore::Shop.find_by(id: shop_id)
        @user = @shop.users.new

        MagazCore::User.connection.transaction do
          begin
            _create_user!(user: @user, params: params)

          rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid
            raise ActiveRecord::Rollback
          end
        end
      end

      private

      def _create_user!(user:, params:)
        user.update_attributes(first_name: params[:first_name],
                               last_name: params[:last_name],
                               email: params[:email],
                               password: params[:password])
        user.save!
      end
    end
  end
end