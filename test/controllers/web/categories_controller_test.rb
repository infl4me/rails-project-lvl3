# frozen_string_literal: true

require 'test_helper'

class Web::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:category_one)
    @user = users(:user_admin)
    sign_in @user
  end

  test 'should create category' do
    assert_difference('Category.count') do
      post admin_categories_url, params: { category: { name: @category.name } }
    end

    assert_redirected_to admin_categories_url
  end

  test 'should get edit' do
    get edit_admin_category_url(@category)
    assert_response :success
  end

  test 'should update category' do
    patch admin_category_url(@category), params: { category: { name: @category.name } }
    assert_redirected_to admin_categories_url
  end

  test 'should destroy category' do
    assert_difference('Category.count', -1) do
      delete admin_category_url(@category)
    end

    assert_redirected_to admin_categories_url
  end
end
