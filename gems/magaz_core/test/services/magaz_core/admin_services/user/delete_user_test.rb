require 'test_helper'

class MagazCore::AdminServices::User::DeleteUserTest < ActiveSupport::TestCase

  setup do 
    @shop = create(:shop, name: "Shop name")
    @user = create(:user)
  end

end