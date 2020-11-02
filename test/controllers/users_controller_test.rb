require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:regular)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: "bob@example.com", username: "bob", password: "password" } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit when same user is logged in" do
    sign_in_as(@user)

    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user when same user is logged in" do
    sign_in_as(@user)

    patch user_url(@user), params: { user: { email: @user.email, username: @user.username } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user when same user is logged in" do
    sign_in_as(@user)

    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end

  test "should redirect to profile page when logged in and attempting to edit other user's profile" do
    sign_in_as(@user)
    admin_user = users(:admin)

    get edit_user_url(admin_user)
    assert_redirected_to user_url(admin_user)
  end

  test "should redirect to profile page when logged in and attempting to update other user's profile" do
    sign_in_as(@user)
    admin_user = users(:admin)

    patch user_url(admin_user), params: { user: { email: admin_user.email, username: admin_user.username } }
    assert_redirected_to user_url(admin_user)
  end

  test "should redirect to profile page when logged in and attempting to destroy other user's profile" do
    sign_in_as(@user)
    admin_user = users(:admin)

    assert_difference('User.count', 0) do
      delete user_url(admin_user)
    end

    assert_redirected_to user_url(admin_user)
  end

  test "should redirect to login page when attempting to edit a user" do
    get edit_user_url(@user)
    assert_redirected_to login_path
  end

  test "should redirect to login page when attempting to update a user" do
    patch user_url(@user), params: { user: { email: @user.email, username: @user.username } }
    assert_redirected_to login_path
  end

  test "should redirect to login page when attempting to destroy a user" do
    delete user_url(@user)
    assert_redirected_to login_path
  end

  test "should be able to edit other user when admin user is logged in" do
    admin_user = users(:admin)
    sign_in_as(admin_user)

    get edit_user_url(@user)
    assert_response :success
  end

  test "should be able to update other user when admin user is logged in" do
    admin_user = users(:admin)
    sign_in_as(admin_user)

    patch user_url(@user), params: { user: { email: @user.email, username: @user.username } }
    assert_redirected_to user_url(@user)
  end

  test "should be able to destroy other user when admin user is logged in" do
    admin_user = users(:admin)
    sign_in_as(admin_user)

    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end

  test "should not be able to access sign up when user is logged in" do
    sign_in_as(@user)

    get signup_url
    assert_redirected_to root_url 
  end
  test "should not be able to create new user when user is logged in" do
    sign_in_as(@user)

    assert_difference('User.count', 0) do
      post users_url, params: { user: { email: "bob@example.com", username: "bob", password: "password" } }
    end
    assert_redirected_to root_url 
  end
end
