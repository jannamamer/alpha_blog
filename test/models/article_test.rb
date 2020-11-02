require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = users(:admin)
    @article = Article.new(title: "Test title", description: "Test description", user_id: @user.id)
  end

  test "article should be valid" do
    assert @article.valid?
  end

  test "article's title and description should be present" do
    @article.title = ""
    @article.description = ""

    assert_not @article.valid?
    assert @article.errors.has_key?(:title)
    assert @article.errors.has_key?(:description)
  end

  test "article's title should be at least 6 characters" do
    @article.title = "short"

    assert_not @article.valid?
    assert @article.errors.has_key?(:title)
  end

  test "article's title should not be longer than 100 characters" do
    @article.title = "l#{'o' * 100}ng"

    assert_not @article.valid?
    assert @article.errors.has_key?(:title)
  end

  test "article's description should be at least 10 characters" do
    @article.description = "too short"

    assert_not @article.valid?
    assert @article.errors.has_key?(:description)
  end

  test "article's description should not be longer than 300 characters" do
    @article.description = "t#{'o' * 300} long"

    assert_not @article.valid?
    assert @article.errors.has_key?(:description)
  end

  test "article's user_id should be present" do
    @article.user_id = nil

    assert_not @article.valid?
    assert @article.errors.has_key?(:user_id)
  end

  # test "article's user_id should exists in users" do
    # @article.user_id = User.count + 1

    # assert_not @article.valid?
    # assert @article.errors.has_key?(:user_id)
  # end
end
