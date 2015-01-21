require 'test_helper'

module MagazCore
  class UserMailerTest < ActionMailer::TestCase
    
    test "test notification" do
      user = MagazCore::User.first
      mail = MagazCore::UserMailer.test_notification(user)
      assert_equal "Test notification", mail.subject
      assert_equal [user.email], mail.to
      assert_equal ["notifications@example.com"], mail.from
    end
  end
end
