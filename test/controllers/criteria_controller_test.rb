require "test_helper"

class CriteriaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get discussion_criteria_url(discussion_id: 1)

    json = JSON.parse(response.body)
    assert_equal 2, json.size, "should get 2 criterias"

    assert_response :success
  end

  test "should get success show on create" do
    post discussion_criteria_url(discussion_id: 1),
      params: {
        text: 'It\'s a test criteria'
      },
      headers: { "Authorization" => "123456" }

    json = JSON.parse(response.body)
    assert_equal 'It\'s a test criteria', json['text']

    assert_response :success
  end

  test "should get error message show on create with non-existing user" do
    post discussion_criteria_url(discussion_id: 1),
      params: {
        text: 'It\'s a test criteria'
      },
      headers: { "Authorization" => "111111" }

    assert_match /session_token expired or doesn't exists/, JSON.parse(response.body)['message']
    assert_response :unauthorized
  end

  test "should get error message show on create with non-owner user" do
    post discussion_criteria_url(discussion_id: 1),
      params: {
        text: 'It\'s a test criteria'
      },
      headers: { "Authorization" => "222222" }

    assert_match /User with id=/, JSON.parse(response.body)['message']
    assert_response :forbidden
  end

  test "should get error message show on create with non-existing discussion" do
    post discussion_criteria_url(discussion_id: 100),
      params: {
        text: 'It\'s a test criteria'
      },
      headers: { "Authorization" => "123456" }

    assert_match /Couldn't find Discussion/, JSON.parse(response.body)['message']
    assert_response :not_found
  end
end
