# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:regular)
  end

  test 'should get index' do
    get users_url
    assert_response :success
  end

  test 'should get new' do
    get new_user_registration_path
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_url,
           params: {
             user: {
               email: 'bob@example.com',
               username: 'bob',
               password: 'password',
               first_name: 'bob',
               last_name: 'example'
             }
           }
    end

    assert_redirected_to root_url
  end

  test 'should show user' do
    get user_url(@user)
    assert_response :success
  end

  test 'should get edit when same user is logged in' do
    sign_in_as(@user)

    get edit_user_registration_path(@user)
    assert_response :success
  end

  test 'should be able to edit other user when admin user is logged in' do
    admin_user = users(:admin)
    sign_in_as(admin_user)

    get edit_user_registration_path(@user)
    assert_response :success
  end

  test 'should not be able to access sign up when user is logged in' do
    sign_in_as(@user)

    get new_user_registration_path
    assert_redirected_to root_url
  end

  test 'should not be able to create new user when user is logged in' do
    sign_in_as(@user)

    assert_difference('User.count', 0) do
      post users_url, params: { user: { email: 'bob@example.com', username: 'bob', password: 'password' } }
    end
    assert_redirected_to root_url
  end
end
