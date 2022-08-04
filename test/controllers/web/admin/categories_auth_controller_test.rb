# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesAuthControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:category_one)
    @user = users(:user_one)
    sign_in @user
  end

  test 'should not be permitted to get index' do
    get admin_categories_url
    assert_response :forbidden
  end

  test 'should not be permitted to get new' do
    get new_admin_category_url
    assert_response :forbidden
  end

  test 'should not be permitted to show bulletin' do
    get admin_category_url(@category)
    assert_response :forbidden
  end

  test 'should not be permitted to create category' do
    name = Faker::Lorem.word

    post admin_categories_url, params: { category: { name: name } }

    assert { Category.find_by(name: name).nil? }
    assert_response :forbidden
  end

  test 'should not be permitted to get edit' do
    get edit_admin_category_url(@category)
    assert_response :forbidden
  end

  test 'should not be permitted to update category' do
    patch admin_category_url(@category), params: { category: { name: @category.name } }
    assert_response :forbidden
  end

  test 'should not be permitted to destroy category' do
    delete admin_category_url(@category)

    Category.find @category.id
    assert_response :forbidden
  end
end
