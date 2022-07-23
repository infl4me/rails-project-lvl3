# frozen_string_literal: true

require 'test_helper'

class Web::Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_admin)
    sign_in @user
  end

  test 'should get index' do
    get admin_users_url
    assert_response :success
  end
end
