require 'rails_helper'

RSpec.describe 'Tacos API', type: :request do
  # initialize test data 
  let!(:tacos) { create_list(:taco, 10) }
  let(:taco_id) { tacos.first.id }

  # Test suite for GET /tacos
  describe 'GET /tacos' do
    # make HTTP get request before each example
    before { get '/tacos' }

    it 'returns tacos' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /tacos/:id
  describe 'GET /tacos/:id' do
    before { get "/tacos/#{taco_id}" }

    context 'when the record exists' do
      it 'returns the taco' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(taco_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:taco_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Taco/)
      end
    end
  end

  # Test suite for POST /tacos
  describe 'POST /tacos' do
    # valid payload
    let(:valid_attributes) { {taco: attributes_for(:taco, :chicken)} }

    context 'when the request is valid' do
      before { post '/tacos', params: valid_attributes }

      it 'creates a taco' do
        expect(json['meat']).to eq('chicken')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid with invalid meat' do
      let(:invalid_attributes) { {taco: attributes_for(:taco, :invalid)} }
      before { post '/tacos', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Invalid parameter: 'invalid' is not a valid meat/)
      end
    end

    context 'when the request is invalid with nil meat' do
      let(:invalid_attributes) { {taco: attributes_for(:taco, :nil_meat)} }
      before { post '/tacos', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Meat can't be blank/)
      end
    end

  end

  # Test suite for PUT /tacos/:id
  describe 'PUT /tacos/:id' do
    let(:valid_attributes) { {taco: attributes_for(:taco, :update_notes)} }

    context 'when the record exists' do
      before { put "/tacos/#{taco_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /tacos/:id
  describe 'DELETE /tacos/:id' do
    before { delete "/tacos/#{taco_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end