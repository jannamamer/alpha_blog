# frozen_string_literal: true

require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:regular)
    @article = articles(:one)
  end

  test 'should get index' do
    get articles_url
    assert_response :success
  end

  test 'should get new' do
    sign_in_as(@user)

    get new_article_url
    assert_response :success
  end

  test 'should create article when user is logged in' do
    sign_in_as(@user)

    assert_difference('Article.count') do
      post articles_url, params: { article: { description: @article.description, title: @article.title } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test 'should show article' do
    get article_url(@article)
    assert_response :success
  end

  test 'should get edit when same user is logged in' do
    sign_in_as(@user)

    get edit_article_url(@article)
    assert_response :success
  end

  test 'should update article when same user is logged in' do
    sign_in_as(@user)

    patch article_url(@article), params: { article: { description: @article.description, title: @article.title } }
    assert_redirected_to article_url(@article)
  end

  test 'should destroy article when same user is logged in' do
    sign_in_as(@user)

    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end

  # test pagination
end
