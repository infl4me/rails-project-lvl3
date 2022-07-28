# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:user_one)
    @bulletin = bulletins(:bulletin_one)
  end

  test 'should get index' do
    get bulletins_url
    assert_response :success
  end

  test 'should get new' do
    get new_bulletin_url
    assert_response :success
  end

  test 'should create bulletin' do
    assert_difference('Bulletin.count') do
      post bulletins_url, params: {
        bulletin: {
          category_id: @bulletin.category_id,
          description: @bulletin.description,
          title: @bulletin.title,
          user_id: @bulletin.user_id,
          image: Rack::Test::UploadedFile.new(Rails.root.join('test/fixtures/files/image.jpg'))
        }
      }
    end

    assert_redirected_to bulletin_url(Bulletin.last)
  end

  test 'should show bulletin' do
    get bulletin_url(@bulletin)
    assert_response :success
  end

  test 'should get edit' do
    get edit_bulletin_url(@bulletin)
    assert_response :success
  end

  test 'should update bulletin' do
    patch bulletin_url(@bulletin), params: { bulletin: { category_id: @bulletin.category_id, description: @bulletin.description, title: @bulletin.title, user_id: @bulletin.user_id } }
    assert_redirected_to bulletin_url(@bulletin)
  end

  test 'should destroy bulletin' do
    assert_difference('Bulletin.count', -1) do
      delete bulletin_url(@bulletin)
    end

    assert_redirected_to profile_path
  end

  test 'should archive bulletin' do
    patch archive_bulletin_url(@bulletin)

    assert_redirected_to profile_path
    assert { Bulletin.find(@bulletin.id).archived? }
  end

  test 'should send bulletin to moderation' do
    patch to_moderate_bulletin_url(@bulletin)

    assert_redirected_to profile_path
    assert { Bulletin.find(@bulletin.id).under_moderation? }
  end
end
