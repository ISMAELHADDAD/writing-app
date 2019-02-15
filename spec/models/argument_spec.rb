require 'rails_helper'

RSpec.describe Argument, type: :model do
  # Association test
  it { should belong_to(:discussion) }
  it { should belong_to(:avatar) }
  # Validation tests
  # ensure columns are present before saving
  it { should validate_presence_of(:num) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:publish_time) }
end
