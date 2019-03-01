require "test_helper"

class UserTest < ActiveSupport::TestCase
  before do
    @subject = users(:user_1)
  end

  test 'is valid' do
    # Associations tests
    must have_many(:discussions).dependent(:destroy)
    must have_many(:avatars)
    # Validation tests
    must validate_uniqueness_of(:name)
  end

end
