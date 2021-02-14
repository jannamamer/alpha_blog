# frozen_string_literal: true

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: 'Sports')
  end

  test 'category should be valid' do
    assert @category.valid?
  end

  test 'name should be present' do
    @category.name = ''
    assert_not @category.valid?
  end

  test 'name should be unique' do
    @category.save

    @category2 = Category.new(name: 'Sports')
    assert_not @category2.valid?
  end

  test 'name should not be longer than 25 characters' do
    @category.name = 'Name longer than 25 characters'
    assert_not @category.valid?
  end

  test 'name should be at least 3 characters' do
    @category.name = 'ok'
    assert_not @category.valid?
  end
end
