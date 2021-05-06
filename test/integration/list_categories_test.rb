# frozen_string_literal: true

require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:regular)
    @category = Category.create(name: 'Sports')
    @category2 = Category.create(name: 'Travel')
  end

  test 'should show categories listing' do
    sign_in_as(@user)

    get categories_url
    assert_select 'a[href=?]', category_path(@category), text: @category.name
    assert_select 'a[href=?]', category_path(@category2), text: @category2.name
  end
end
