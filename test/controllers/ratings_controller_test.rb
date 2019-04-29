require "test_helper"

class RatingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get discussion_avatar_ratings_url(discussion_id: 1, avatar_id: 1)

    json = JSON.parse(response.body)
    assert_equal 2, json.size, "should get 2 ratings"

    assert_response :success
  end

  test "should get error message on index with non-existing discussion" do
    get discussion_avatar_ratings_url(discussion_id: 100, avatar_id: 1)

    assert_match /Couldn't find Discussion/, JSON.parse(response.body)['message']
    assert_response :not_found
  end

  test "should get error message on index with non-participating avatar" do
    get discussion_avatar_ratings_url(discussion_id: 1, avatar_id: 3)

    assert_match /Avatar with id=/, JSON.parse(response.body)['message']
    assert_response :forbidden
  end

  test "should get success show on update" do
    put discussion_avatar_rating_url(discussion_id: 1, avatar_id: 1, id: 2),
      params: {
        rating: 5
      },
      headers: { "Authorization" => "123456" }

    json = JSON.parse(response.body)
    assert_equal 2, json['id'], "should update rating with id <rating_id>"
    assert_equal 5, json['rating'], "should get rating set to 5"

    assert_response :success
  end

  test "should get error message show on update with non-existing user" do
    put discussion_avatar_rating_url(discussion_id: 1, avatar_id: 1, id: 2),
      params: {
        rating: 5
      },
      headers: { "Authorization" => "111111" }

    assert_match /session_token expired or doesn't exists/, JSON.parse(response.body)['message']
    assert_response :unauthorized
  end

  test "should get error message show on update with non-owner user" do
    put discussion_avatar_rating_url(discussion_id: 1, avatar_id: 1, id: 2),
      params: {
        rating: 5
      },
      headers: { "Authorization" => "222222" }

    assert_match /is not an owner/, JSON.parse(response.body)['message']
    assert_response :forbidden
  end

  test "should get error message show on update with non-participating avatar" do
    put discussion_avatar_rating_url(discussion_id: 1, avatar_id: 3, id: 2),
      params: {
        rating: 5
      },
      headers: { "Authorization" => "123456" }

    assert_match /does not participate/, JSON.parse(response.body)['message']
    assert_response :forbidden
  end

  test "should get error message show on update with non-existing discussion" do
    put discussion_avatar_rating_url(discussion_id: 100, avatar_id: 1, id: 2),
      params: {
        rating: 5
      },
      headers: { "Authorization" => "123456" }

    assert_match /Couldn't find Discussion/, JSON.parse(response.body)['message']
    assert_response :not_found
  end

  test "should get error message show on update with out-of-range rating" do
    put discussion_avatar_rating_url(discussion_id: 1, avatar_id: 1, id: 2),
      params: {
        rating: 6
      },
      headers: { "Authorization" => "123456" }

    assert_match /Invalid data/, JSON.parse(response.body)['message']
    assert_response :unprocessable_entity
  end
end
