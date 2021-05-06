# frozen_string_literal: true

require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  test 'get new and sign up user' do
    get new_user_registration_path
    assert_response :success

    assert_difference('User.count') do
      post user_registration_path,
           params: {
             user: {
               first_name: 'bob',
               last_name: 'example',
               email: 'bob@example.com',
               username: 'bob',
               password: 'password',
               password_confirmation: 'password'
             }
           }
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_redirected_to articles_path
  end

  test 'get new and reject invalid user submission' do
    get new_user_registration_path
    assert_response :success
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: 'bob@example.com', username: 'bob', password: '' } }
    end

    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
