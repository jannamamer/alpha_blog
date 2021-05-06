# frozen_string_literal: true

# Functional or controller test tests the individual function
# Integration test tests the whole process of a feature
require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin)
    sign_in_as(@admin_user)
  end

  test 'get new category form and create category' do
    get new_category_url
    assert_response :success
    assert_difference('Category.count', 1) do
      post categories_url, params: { category: { name: 'Travel' } }
    end

    assert_redirected_to category_url(Category.last)
    follow_redirect!
    assert_response :success
    assert_match 'Travel', response.body
  end

  test 'get new category form and reject invalid category submission' do
    get new_category_url
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_url, params: { category: { name: '' } }
    end

    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
