require "test_helper"

class MagazCore::AdminServices::Comment::ChangeCommentTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @comment = create(:comment, blog: @blog, article: @article)
    @success_params = {id: @comment.id,
                       author: "Changed author",
                       email: "test@test.com",
                       body: "Changed body"}
    @blank_params = { id: @comment.id, author: "", email: "", body: "" }
  end

  test 'should update comment with valid params' do
    service = MagazCore::AdminServices::Comment::ChangeComment.run(@success_params)
    assert service.valid?
    assert service.result
    assert_equal "Changed body", MagazCore::Comment.find(@comment.id).body
    assert_equal "test@test.com", MagazCore::Comment.find(@comment.id).email
  end

  test 'should not update comment with invalid email' do
    service = MagazCore::AdminServices::Comment::ChangeComment
                .run(id: @comment.id,
                     author: "Changed author",
                     email: "wrong",
                     body: "Changed body")
    assert_not service.valid?
    assert_equal 1, service.comment.errors.count
    assert_equal "Email is not valid", service.comment.errors.full_messages.last
  end

  test 'should not update comment with blank params' do
    service = MagazCore::AdminServices::Comment::ChangeComment.run(@blank_params)
    refute service.valid?
    assert_equal 4, service.comment.errors.full_messages.count
    assert_equal "Author can't be blank", service.comment.errors.full_messages.first
    assert_equal "Email can't be blank", service.comment.errors.full_messages[1]
    assert_equal "Body can't be blank", service.comment.errors.full_messages[2]
    assert_equal "Email is not valid", service.comment.errors.full_messages.last
    assert_equal @comment.body, MagazCore::Comment.find(@comment.id).body
  end
end
