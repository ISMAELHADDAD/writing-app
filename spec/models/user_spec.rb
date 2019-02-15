require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  it { should have_many(:discussions).dependent(:destroy) }
  it { should have_many(:avatars) }
  # Validation tests
  # ensure columns are present before saving
  it { should validate_presence_of(:name) }
end
