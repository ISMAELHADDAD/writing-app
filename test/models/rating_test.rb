require "test_helper"

class RatingTest < ActiveSupport::TestCase
  before do
    @subject = ratings(:rating_1)
  end

  test 'is valid' do
    # Association test
    must belong_to(:avatar)
    must belong_to(:criterium)
    # Validation tests
    must validate_inclusion_of(:rating).in_range(0..5)
  end
end
