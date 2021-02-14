# frozen_string_literal: true

require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  test 'get new and sign up user' do
    get signup_url
    assert_response :success
    assert_difference('User.count') do
      post users_url, params: { user: { email: 'bob@example.com', username: 'bob', password: 'password' } }
    end

    assert_redirected_to user_url(User.last)
    follow_redirect!
    assert_response :success
    assert_match 'Welcome to Alpha Blog', response.body
  end

  test 'get new and reject invalid user submission' do
    get signup_url
    assert_response :success
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: 'bob@example.com', username: 'bob', password: '' } }
    end

    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
