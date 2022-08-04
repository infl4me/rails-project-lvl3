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
    title = Faker::Lorem.word
    description = Faker::Lorem.paragraph

    post bulletins_url, params: {
      bulletin: {
        category_id: Category.first.id,
        description: description,
        title: title,
        user_id: current_user.id,
        image: Rack::Test::UploadedFile.new(Rails.root.join('test/fixtures/files/image.jpg'))
      }
    }

    bulletin = Bulletin.find_by! title: title, description: description
    assert_redirected_to bulletin_url(bulletin)
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

  test 'not owner should not be able to update bulletin' do
    sign_in users(:user_two)
    patch bulletin_url(@bulletin), params: { bulletin: { category_id: @bulletin.category_id, description: @bulletin.description, title: @bulletin.title, user_id: @bulletin.user_id } }

    assert_response :forbidden
  end

  test 'should destroy bulletin' do
    delete bulletin_url(@bulletin)

    assert { Bulletin.find_by(id: @bulletin.id).nil? }
    assert_redirected_to profile_path
  end

  test 'not owner should not be able to destroy bulletin' do
    sign_in users(:user_two)

    delete bulletin_url(@bulletin)

    Bulletin.find @bulletin.id
    assert_response :forbidden
  end

  test 'should archive bulletin' do
    patch archive_bulletin_url(@bulletin)

    assert_redirected_to profile_path
    assert { Bulletin.find(@bulletin.id).archived? }
  end

  test 'not owner should not be able to archive bulletin' do
    sign_in users(:user_two)
    patch archive_bulletin_url(@bulletin)

    assert_response :forbidden
  end

  test 'should send bulletin to moderation' do
    patch to_moderate_bulletin_url(@bulletin)

    assert_redirected_to profile_path
    assert { Bulletin.find(@bulletin.id).under_moderation? }
  end

  test 'not owner should not be able to send bulletin to moderation' do
    sign_in users(:user_two)
    patch to_moderate_bulletin_url(@bulletin)

    assert_response :forbidden
  end
end
