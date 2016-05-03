require 'test_helper'

class MagazCore::AdminServices::Comment::AddCommentTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @blog = create(:blog, shop: @shop)
    @article = create(:article, blog: @blog)
    @blog2 = create(:blog, shop: @shop)
    @article2 = create(:article, blog: @blog2)
    @success_params = {author: "Test author",
                       email: "test@test.com",
                       body: "Test body",
                       article_id: @article.id,
                       blog_id: @blog.id}
    @blank_params = {author: "",
                     email: "",
                     body: "",
                     article_id: @article.id,
                     blog_id: @blog.id}
    @invalid_param = {author: "author",
                      email: "wrong",
                      body: "Test body",
                      article_id: @article2.id,
                      blog_id: @blog.id}
  end

  test 'should create comment with valid params' do
    service = MagazCore::AdminServices::Comment::AddComment.run(@success_params)
    assert service.valid?
    assert MagazCore::Comment.find_by_id(service.result.id)
    assert_equal 'Test author', service.result.author
    assert_equal 1, MagazCore::Comment.count
  end

  test 'should not create comment with blank params' do
    service = MagazCore::AdminServices::Comment::AddComment.run(@blank_params)
    refute service.valid?
    assert_equal 4, service.comment.errors.full_messages.count
    assert_equal "Author can't be blank", service.comment.errors.full_messages.first
    assert_equal "Body can't be blank", service.comment.errors.full_messages[1]
    assert_equal "Email can't be blank", service.comment.errors.full_messages[2]
    assert_equal "Email is not valid", service.comment.errors.full_messages.last
    assert_equal 0, MagazCore::Comment.count
  end

  test 'should not create comment with invalid_param' do
    service = MagazCore::AdminServices::Comment::AddComment.run(@invalid_param)
    refute service.valid?
    assert_equal 0, MagazCore::Comment.count
    assert_equal 2, service.comment.errors.full_messages.count
    assert_equal "Email is not valid",
                 service.comment.errors.full_messages.first
    assert_equal "This article is not belongs to this blog",
                 service.comment.errors.full_messages.last
  end
end