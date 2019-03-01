require "test_helper"

class AvatarTest < ActiveSupport::TestCase
  before do
    @subject = avatars(:avatar_1)
  end

  test 'is valid' do
    # Association test
    must have_many(:arguments).dependent(:destroy)
    must have_many(:agreements).dependent(:destroy)
    must belong_to(:discussion)
    must belong_to(:user)
    # Validation tests
    must validate_presence_of(:name)
  end
end
