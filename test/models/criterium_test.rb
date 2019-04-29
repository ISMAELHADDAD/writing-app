require "test_helper"

class CriteriumTest < ActiveSupport::TestCase
  before do
    @subject = criteria(:criterium_1)
  end

  test 'is valid' do
    # Association test
    must belong_to(:discussion)
    # Validation tests
    must validate_presence_of(:text)
  end
end
