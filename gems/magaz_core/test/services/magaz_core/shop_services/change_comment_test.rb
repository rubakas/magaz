require "test_helper"

module MagazCore
  class ShopServices::ChangeCommentTest < ActiveSupport::TestCase

    setup do
      @shop = create(:shop, name: 'shop_name')
      @blog = create(:blog, shop: @shop)
      @article = create(:article, blog: @blog)
      @comment = create(:comment, blog: @blog, article: @article)
      @success_params = { id: @comment.id, author: "Changed author", email: "Changed test@test.com", body: "Changed body"}
      @blank_params = { id: nil, author: nil, email: nil, body: nil }
    end

    test 'should update comment with valid params' do
      service = MagazCore::ShopServices::ChangeComment.run(@success_params)
      assert service.valid?
      assert_equal "Changed body", MagazCore::Comment.find(@comment.id).body
      assert_equal "Changed test@test.com", MagazCore::Comment.find(@comment.id).email
    end

    test 'should not update comment with blank params' do 
      service = MagazCore::ShopServices::ChangeComment.run(@blank_params)
      refute service.valid?
      assert_equal 4, service.errors.full_messages.count
      assert_equal "Comment 1", MagazCore::Comment.find(@comment.id).body
    end
  end
end