require 'rails_helper'

RSpec.describe Avatar, type: :model do
  # Association test
  it { should have_many(:arguments).dependent(:destroy) }
  it { should have_many(:agreements).dependent(:destroy) }
  it { should belong_to(:discussion) }
  it { should belong_to(:user) }
  # Validation tests
  # ensure columns are present before saving
  it { should validate_presence_of(:name) }
end
