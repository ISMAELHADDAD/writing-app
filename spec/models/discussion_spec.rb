require 'rails_helper'

RSpec.describe Discussion, type: :model do
  # Association test
  it { should have_many(:arguments).dependent(:destroy) }
  it { should have_many(:agreements).dependent(:destroy) }
  it { should have_many(:avatars).dependent(:destroy) }
  it { should belong_to(:user) }
  
  # Validation tests
  # ensure columns are present before saving
  it { should validate_presence_of(:topicTitle) }
  it { should validate_presence_of(:user_id) }
end
