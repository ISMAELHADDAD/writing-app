require "test_helper"

class DiscussionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    discussion = discussions(:discussion_1)

    get discussion_url(id:1)

    json = JSON.parse(response.body)
    assert_equal json['id'], discussion.id
    assert_equal json['topicTitle'], discussion.topic_title
    assert_equal json['topicDescription'], discussion.topic_description
    assert_equal json['ownerUserId'], discussion.user.id
    assert_equal json['arguments'].size, discussion.arguments.size
    assert_equal json['agreements'].size, discussion.agreements.size

    assert_response :success
  end

  test "should not get show" do
    get discussion_url(id:100)
    assert_response :not_found
  end

  test "should get success message on invite" do
    post discussion_invite_url(discussion_id: 1),
      params: {
        email: 'to@example.com'
      },
      headers: { "Authorization" => "123456" }

    assert_match /Invitation send/, JSON.parse(response.body)['message']
  end

  test "should get error message on invite with unauthorized user" do
    post discussion_invite_url(discussion_id: 1),
      params: {
        email: 'to@example.com'
      },
      headers: { "Authorization" => "222222" }

    assert_match /Only owner of the discussion can make invitation/, JSON.parse(response.body)['message']
    assert_response :unauthorized
  end

  test "should get success message on verify_invitation" do
    put discussion_verify_invitation_url(discussion_id: 1),
      params: {
        token: '999999'
      },
      headers: { "Authorization" => "222222" }

    assert_match /Invitation verified/, JSON.parse(response.body)['message']
    assert_response :success
  end

  test "should get error message on verify_invitation with non-existing user" do
    put discussion_verify_invitation_url(discussion_id: 1),
      params: {
        token: '999999'
      },
      headers: { "Authorization" => "111111" }

    assert_match /session_token expired or doesn't exists/, JSON.parse(response.body)['message']
    assert_response :unauthorized
  end

  test "should get error message on verify_invitation with non-existing token" do
    put discussion_verify_invitation_url(discussion_id: 1),
      params: {
        token: '000000'
      },
      headers: { "Authorization" => "222222" }

    assert_match /Couldn't find token invitation/, JSON.parse(response.body)['message']
    assert_response :not_found
  end

  test "should get error message on verify_invitation with token already verified" do
    put discussion_verify_invitation_url(discussion_id: 1),
      params: {
        token: '888888'
      },
      headers: { "Authorization" => "123456" }

    assert_match /Token already verified/, JSON.parse(response.body)['message']
    assert_response :forbidden
  end

end
