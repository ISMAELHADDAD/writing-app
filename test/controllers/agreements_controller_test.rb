require "test_helper"

class AgreementsControllerTest < ActionDispatch::IntegrationTest
  test "should get success show on create" do
    post discussion_agreements_url(discussion_id: 1),
      params: {
        avatar_id: 1,
        content: 'It\'s a test agreement',
        is_agree: true
      },
      headers: { "Authorization" => "123456" }

    json = JSON.parse(response.body)
    assert_equal 'It\'s a test agreement', json['content']
    assert_equal true, json['isAgree']
    assert_equal 1, json['proposedByAvatarId']

    assert_response :success
  end

  test "should get error message show on create with non-existing user" do
    post discussion_agreements_url(discussion_id: 1),
      params: {
        avatar_id: 1,
        content: 'It\'s a test agreement',
        is_agree: true
      },
      headers: { "Authorization" => "111111" }
    assert_match /session_token expired or doesn't exists/, JSON.parse(response.body)['message']
    assert_response :unauthorized
  end

  test "should get error message show on create with non-existing avatar" do
    post discussion_agreements_url(discussion_id: 1),
      params: {
        user_id: 1,
        avatar_id: 100,
        content: 'It\'s a test agreement',
        is_agree: true
      },
      headers: { "Authorization" => "123456" }
    assert_match /Couldn't find Avatar/, JSON.parse(response.body)['message']
    assert_response :not_found
  end

  test "should get success message on update for reject" do
    put discussion_agreement_url(discussion_id: 1, id: 1),
      params: {
        user_id: 1,
        avatar_id: 2,
        is_accepted: "false"
      },
      headers: { "Authorization" => "123456" }

    assert_match /Agreement rejected and deleted/, JSON.parse(response.body)['message']
    assert_response :success
  end

  test "should get error message on update for reject with wrong avatar" do
    put discussion_agreement_url(discussion_id: 1, id: 1),
      params: {
        user_id: 1,
        avatar_id: 1,
        is_accepted: "false"
      },
      headers: { "Authorization" => "123456" }

    assert_match /Invalid data/, JSON.parse(response.body)['message']
    assert_response :unprocessable_entity
  end
end
