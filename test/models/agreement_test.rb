require "test_helper"

class AgreementTest < ActiveSupport::TestCase
  before do
    @subject = agreements(:agreement_1)
  end

  test 'is valid' do
    # Association test
    must belong_to(:avatar)
    must belong_to(:discussion)
    # Validation tests
    must validate_presence_of(:content)
  end

end
