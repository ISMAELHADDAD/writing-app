require 'rails_helper'

RSpec.describe 'Discussions API', type: :request do
  # initialize test data
  let(:discussion_id) { 1 }

  # Test suite for GET /discussions/:id
  describe 'GET /discussions/:id' do
    before { get "/discussions/#{discussion_id}" }

    context 'when the record exists' do
      it 'returns the discussion' do
        expect(json).not_to be_empty
        # expect(json['id']).to eq(discussion_id)
        # expect(json['topicTitle']).to eq(discussion.topicTitle)
        # expect(json['topicDescription']).to eq(discussion.topicDescription)
        # expect(json['owner']).to eq(discussion.user.id)
        # expect(json['arguments'].size).to eq(discussion.arguments.size)
        # expect(json['agreements'].size).to eq(discussion.agreements.size)
        # expect(json['avatar']).to eq(discussion.avatar.size)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:discussion_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

end
