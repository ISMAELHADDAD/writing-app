require "test_helper"

class ArgumentTest < ActiveSupport::TestCase
  before do
    @subject = arguments(:argument_1)
  end

  test 'is valid' do
    # Association test
    must belong_to(:discussion)
    must belong_to(:avatar)
    # Validation tests
    must validate_presence_of(:num)
    must validate_presence_of(:content)
    must validate_presence_of(:publish_time)
  end
end
