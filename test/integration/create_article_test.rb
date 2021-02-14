# frozen_string_literal: true

require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:regular)
    sign_in_as(@user)
  end

  test 'get new article and create article' do
    get new_article_url
    assert_response :success
    assert_difference('Article.count') do
      post articles_url, params: { article: { description: 'Article test description', title: 'Article test title' } }
    end

    assert_redirected_to article_url(Article.last)
    follow_redirect!
    assert_response :success
    assert_match 'Article test title', response.body
  end

  test 'get new article form and reject invalid article submission' do
    get new_article_url
    assert_response :success
    assert_no_difference 'Article.count' do
      post articles_url, params: { article: { description: 'Article test description', title: '' } }
    end

    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
