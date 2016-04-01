require 'test_helper'

class MagazCore::AdminServices::Comment::DeleteCommentTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @blog = create(:blog, shop: @shop)
    @article = create(:article, blog: @blog)
    @comment = create(:comment, article: @article)
    @comment2 = create(:comment, article: @article)
  end

  test 'should delete comment with valid id' do
    assert_equal 2, @article.comments.count
    service = MagazCore::AdminServices::Comment::DeleteComment.run(id: @article.id)
    assert service.valid?
    refute MagazCore::Comment.find_by_id(@comment.id)
    assert MagazCore::Comment.find_by_id(@comment2.id)
    assert_equal 1, @article.comments.count
  end

  test 'should not delete comment with blank id' do
    assert_equal 2, @article.comments.count
    service = MagazCore::AdminServices::Comment::DeleteComment.run(id: "")
    refute service.valid?
    assert MagazCore::Comment.find_by_id(@comment.id)
    assert MagazCore::Comment.find_by_id(@comment2.id)
    assert_equal 2, @article.comments.count
  end
end
