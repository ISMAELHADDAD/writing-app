require 'rails_helper'

RSpec.describe Agreement, type: :model do
  # Association test
  it { should belong_to(:avatar) }
  it { should belong_to(:discussion) }
  # Validation tests
  # ensure columns are present before saving
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:isAccepted) }
  it { should validate_presence_of(:isAgree) }
end
