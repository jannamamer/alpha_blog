# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:admin)
  end

  test 'user should be valid' do
    assert @user.valid?
  end

  test "user's username and email should be unique" do
    @user.save
    @user2 = User.new(username: 'john', email: 'johndoe@example.com', password: 'password')

    assert_not @user2.valid?
    assert @user2.errors.key?(:username)
    assert @user2.errors.key?(:email)
  end

  test "user's username should be present" do
    @user.username = ''

    assert_not @user.valid?
    assert @user.errors.key?(:username)
  end

  test "user's username should not be longer than 25 characters" do
    @user.username = 'a' * 26

    assert_not @user.valid?
    assert @user.errors.key?(:username)
  end

  test "user's username should be at least 3 characters" do
    @user.username = 'ok'

    assert_not @user.valid?
    assert @user.errors.key?(:username)
  end

  test "user's email should be a valid format" do
    @user.email = 'not-a-valid-format'

    assert_not @user.valid?
    assert @user.errors.key?(:email)
  end

  test "user's email should be present" do
    @user.email = ''

    assert_not @user.valid?
    assert @user.errors.key?(:email)
  end

  test "user's email should not be longer than 105 characters" do
    @user.email = "#{'a' * 100}-email-longer-than-105-characters@example.com"

    assert_not @user.valid?
    assert @user.errors.key?(:email)
  end
end
