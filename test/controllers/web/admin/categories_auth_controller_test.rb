# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesAuthControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:category_one)
    @user = users(:user_one)
    sign_in @user
  end

  test '(auth) should not get index' do
    get admin_categories_url
    assert_redirected_to root_path
  end

  test '(auth) should not get new' do
    get new_admin_category_url
    assert_redirected_to root_path
  end

  test '(auth) should not show bulletin' do
    get admin_category_url(@category)
    assert_redirected_to root_path
  end

  test '(auth) should not create category' do
    assert_difference('Category.count', 0) do
      post admin_categories_url, params: { category: { name: @category.name } }
    end

    assert_redirected_to root_path
  end

  test '(auth) should not get edit' do
    get edit_admin_category_url(@category)
    assert_redirected_to root_path
  end

  test '(auth) should not update category' do
    patch admin_category_url(@category), params: { category: { name: @category.name } }
    assert_redirected_to root_path
  end

  test '(auth) should not destroy category' do
    assert_difference('Category.count', 0) do
      delete admin_category_url(@category)
    end

    assert_redirected_to root_path
  end
end
