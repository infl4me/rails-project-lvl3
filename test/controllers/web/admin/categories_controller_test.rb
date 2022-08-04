# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:category_one)
    @user = users(:user_admin)
    sign_in @user
  end

  test 'should get index' do
    get admin_categories_url
    assert_response :success
  end

  test 'should get new' do
    get new_admin_category_url
    assert_response :success
  end

  test 'should show bulletin' do
    get admin_category_url(@category)
    assert_response :success
  end

  test 'should create category' do
    name = Faker::Lorem.word

    post admin_categories_url, params: { category: { name: name } }

    Category.find_by! name: name
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
    delete admin_category_url(@category)

    assert { Category.find_by(id: @category.id).nil? }
    assert_redirected_to admin_categories_url
  end
end
