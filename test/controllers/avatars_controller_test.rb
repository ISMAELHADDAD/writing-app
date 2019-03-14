require "test_helper"

class AvatarsControllerTest < ActionDispatch::IntegrationTest

  test "should get success message on assign" do
    put discussion_avatar_assign_url(discussion_id: 1, avatar_id: 2),
      params: {
        user_id: 1
      },
      headers: { "Authorization" => "123456" }

    assert_match /Avatar with id=2 is assigned to user with id=1/, JSON.parse(response.body)['message']
    assert_response :success
  end

  test "should get error message on assign with non-existing avatar" do
    put discussion_avatar_assign_url(discussion_id: 1, avatar_id: 100),
      params: {
        user_id: 1
      },
      headers: { "Authorization" => "123456" }

    assert_match /Couldn't find Avatar with 'id'=/, JSON.parse(response.body)['message']
    assert_response :not_found
  end

  test "should get error message on assign with non-existing user" do
    put discussion_avatar_assign_url(discussion_id: 1, avatar_id: 2),
      params: {
        user_id: 100
      },
      headers: { "Authorization" => "123456" }

    assert_match /User doesn't exists/, JSON.parse(response.body)['message']
    assert_response :not_found
  end

  test "should get error message on assign with non-participating user" do
    put discussion_avatar_assign_url(discussion_id: 1, avatar_id: 2),
      params: {
        user_id: 4
      },
      headers: { "Authorization" => "123456" }

    assert_match /User isn't participating in the discussion/, JSON.parse(response.body)['message']
    assert_response :forbidden
  end

  test "should get error message on assign with non-participating user access" do
    put discussion_avatar_assign_url(discussion_id: 1, avatar_id: 2),
      params: {
        user_id: 1
      },
      headers: { "Authorization" => "333333" }

    assert_match /User isn't participating in the discussion/, JSON.parse(response.body)['message']
    assert_response :forbidden
  end

end
