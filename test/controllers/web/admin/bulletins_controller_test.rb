# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_admin)
    @bulletin_under_moderation = bulletins(:bulletin_under_moderation)
    sign_in @user
  end

  test 'should get index' do
    get admin_root_path
    assert_response :success
  end

  test 'should not be permitted to get index' do
    sign_in users(:user_one)
    get admin_root_path
    assert_response :forbidden
  end

  test 'should publish bulletin' do
    patch publish_admin_bulletin_url(@bulletin_under_moderation)

    assert_redirected_to admin_root_path
    assert { Bulletin.find(@bulletin_under_moderation.id).published? }
  end

  test 'should not be permitted to publish bulletin' do
    sign_in users(:user_one)
    patch publish_admin_bulletin_url(@bulletin_under_moderation)

    assert_response :forbidden
  end

  test 'should reject bulletin' do
    patch reject_admin_bulletin_url(@bulletin_under_moderation)

    assert_redirected_to admin_root_path
    assert { Bulletin.find(@bulletin_under_moderation.id).rejected? }
  end

  test 'should not be permitted to reject bulletin' do
    sign_in users(:user_one)
    patch reject_admin_bulletin_url(@bulletin_under_moderation)

    assert_response :forbidden
  end

  test 'should archive bulletin' do
    patch archive_admin_bulletin_url(@bulletin_under_moderation)

    assert_redirected_to admin_root_path
    assert { Bulletin.find(@bulletin_under_moderation.id).archived? }
  end

  test 'should not be permitted to archive bulletin' do
    sign_in users(:user_one)
    patch archive_admin_bulletin_url(@bulletin_under_moderation)

    assert_response :forbidden
  end
end
