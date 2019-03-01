require "test_helper"

class AgreementsControllerTest < ActionDispatch::IntegrationTest
  test "should get success show on create" do
    post discussion_agreements_url(discussion_id: 1),
      params: {
        user_id: 1,
        avatar_id: 1,
        content: 'It\'s a test agreement',
        isAgree: true
      }

    json = JSON.parse(response.body)
    assert_equal json['content'], 'It\'s a test agreement'
    assert_equal json['isAgree'], true
    assert_equal json['proposed_by_AvatarID'], 1

    assert_response :success
  end

  test "should get error message show on create with non-existing user" do
    post discussion_agreements_url(discussion_id: 1),
      params: {
        user_id: 100,
        avatar_id: 1,
        content: 'It\'s a test agreement',
        isAgree: true
      }
    assert_match /Couldn't find User/, JSON.parse(response.body)['message']
    assert_response :not_found
  end

  test "should get error message show on create with non-existing avatar" do
    post discussion_agreements_url(discussion_id: 1),
      params: {
        user_id: 1,
        avatar_id: 100,
        content: 'It\'s a test agreement',
        isAgree: true
      }
    assert_match /Couldn't find Avatar/, JSON.parse(response.body)['message']
    assert_response :not_found
  end

  test "should get success message on update for reject" do
    put discussion_agreement_url(discussion_id: 1, id: 1),
      params: {
        user_id: 1,
        avatar_id: 2,
        isAccepted: "false"
      }

    assert_match /Agreement rejected and deleted/, JSON.parse(response.body)['message']
    assert_response :success
  end

  test "should get error message on update for reject with wrong avatar" do
    put discussion_agreement_url(discussion_id: 1, id: 1),
      params: {
        user_id: 1,
        avatar_id: 1,
        isAccepted: "false"
      }

    assert_match /Invalid data/, JSON.parse(response.body)['message']
    assert_response :unprocessable_entity
  end
end
