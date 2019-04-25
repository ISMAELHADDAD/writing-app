require "test_helper"

class GeneralCommentTest < ActiveSupport::TestCase
  before do
    @subject = general_comments(:general_comment_1)
  end

  test 'is valid' do
    # Association test
    must belong_to(:discussion)
    must belong_to(:user)
    # Validation tests
    must validate_presence_of(:text)
  end
end
