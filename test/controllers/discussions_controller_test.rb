require "test_helper"

class DiscussionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    discussion = discussions(:discussion_1)

    get discussion_url(id:1)

    json = JSON.parse(response.body)
    assert_equal json['id'], discussion.id
    assert_equal json['topicTitle'], discussion.topicTitle
    assert_equal json['topicDescription'], discussion.topicDescription
    assert_equal json['owner_UserID'], discussion.user.id
    assert_equal json['arguments'].size, discussion.arguments.size
    assert_equal json['agreements'].size, discussion.agreements.size
    
    assert_response :success
  end

  test "should not get show" do
    get discussion_url(id:100)
    assert_response :not_found
  end
end
