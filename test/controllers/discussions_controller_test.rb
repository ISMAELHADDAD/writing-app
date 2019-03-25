require "test_helper"

class DiscussionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    discussion = discussions(:discussion_1)

    get discussion_url(id:1)

    json = JSON.parse(response.body)
    assert_equal discussion.id, json['id']
    assert_equal discussion.topic_title, json['topicTitle']
    assert_equal discussion.topic_description, json['topicDescription']
    assert_equal discussion.user.id, json['ownerUserId']
    assert_equal discussion.arguments.size, json['arguments'].size
    assert_equal discussion.agreements.size, json['agreements'].size
    assert_equal 1, json['participants'].size

    assert_response :success
  end

  test "should not get show" do
    get discussion_url(id:100)
    assert_response :not_found
  end

  test "should get index" do
    get discussions_url()

    json = JSON.parse(response.body)
    assert_equal 1, json['discussions'].size, "should get 1 discussion"
    assert_equal 1, json['pages']['current'], "should get current pages 1"
    assert_equal 1, json['pages']['total'], "should get total pages 1"

    assert_response :success
  end

  test "should get index with zero discussions" do
    get discussions_url(),
    params: {user_id: 3}

    json = JSON.parse(response.body)
    assert_equal 0, json['discussions'].size, "should get 0 discussion"
    assert_equal 1, json['pages']['current'], "should get current pages 1"
    assert_equal 0, json['pages']['total'], "should get total pages 1"

    assert_response :success
  end

  test "should get created message on create" do
    post discussions_url(),
      params: {
        topic_title: 'test title',
        topic_description: 'test description',
        name_avatar_one: 'test name avatar one',
        opinion_avatar_one: 'test opinion avatar one',
        name_avatar_two: 'test name avatar two',
        opinion_avatar_two: 'test opinion avatar two'
      },
      headers: { "Authorization" => "123456" }

    json = JSON.parse(response.body)
    assert_equal 'test title', json['topicTitle']
    assert_equal 'test description', json['topicDescription']
    assert_equal 1, json['ownerUserId'], 'should be id = 1'
    assert_equal 'test name avatar one', json['avatarOne']['name']
    assert_equal 'test opinion avatar one', json['avatarOne']['opinion']
    assert_equal 'test name avatar two', json['avatarTwo']['name']
    assert_equal 'test opinion avatar two', json['avatarTwo']['opinion']
    assert_equal 0, json['arguments'].size, 'has no arguments'
    assert_equal 0, json['agreements'].size, 'has no agreements'
    assert_equal 1, json['participants'].size, 'should have 1 participant'

    assert_response :created
  end

  test "should get error message on create with unauthorized user" do
    post discussions_url(),
      params: {
        topic_title: 'test title',
        topic_description: 'test description',
        name_avatar_one: 'test name avatar one',
        opinion_avatar_one: 'test opinion avatar one',
        name_avatar_two: 'test name avatar two',
        opinion_avatar_two: 'test opinion avatar two'
      },
      headers: { "Authorization" => "111111" }

    assert_match /session_token expired or doesn't exists/, JSON.parse(response.body)['message']
    assert_response :unauthorized
  end

  test "should get success message on destroy" do
    delete discussion_url(id: 1),
      headers: { "Authorization" => "123456" }

    assert_match /Discussion deleted/, JSON.parse(response.body)['message']
    assert_response :success
  end

  test "should get error message on destroy with unauthorized user" do
    delete discussion_url(id: 1),
      headers: { "Authorization" => "111111" }

    assert_match /session_token expired or doesn't exists/, JSON.parse(response.body)['message']
    assert_response :unauthorized
  end

  test "should get error message on destroy with user not owning the discussion" do
    delete discussion_url(id: 1),
      headers: { "Authorization" => "222222" }

    assert_match /Only owner of the discussion can delete it/, JSON.parse(response.body)['message']
    assert_response :unauthorized
  end

  test "should get success message on invite" do
    post discussion_invite_url(discussion_id: 1),
      params: {
        email: 'to@example.com'
      },
      headers: { "Authorization" => "123456" }

    assert_match /Invitation send/, JSON.parse(response.body)['message']
    assert_response :ok
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

  test "should get success message on fork" do
    put discussion_fork_url(discussion_id: 1),
      headers: { "Authorization" => "123456" }

    assert_match /Forked with success/, JSON.parse(response.body)['message']
    assert_equal 2, JSON.parse(response.body)['id']
    assert_response :success
  end

  test "should get error message on fork with non-existing user" do
    put discussion_fork_url(discussion_id: 1),
      headers: { "Authorization" => "111111" }

    assert_match /session_token expired or doesn't exists/, JSON.parse(response.body)['message']
    assert_response :unauthorized
  end

end
