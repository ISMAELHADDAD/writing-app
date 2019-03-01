require "test_helper"

class DiscussionTest < ActiveSupport::TestCase
  before do
    @subject = discussions(:discussion_1)
  end

  test 'is valid' do
    # Association test
    must have_many(:arguments).dependent(:destroy)
    must have_many(:agreements).dependent(:destroy)
    must have_many(:avatars).dependent(:destroy)
    must belong_to(:user)
    # Validation tests
    must validate_presence_of(:topicTitle)
    must validate_presence_of(:user_id)
  end
end
