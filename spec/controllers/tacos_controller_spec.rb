require 'rails_helper'

RSpec.describe TacosController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Taco. As you add validations to Taco, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { meat: "chicken" ,rice: true ,salsa: false , other_side: true, notes: "Test Notes" }
  }

  let(:invalid_attributes) {
    { rice: true ,salsa: false,other_side: true ,notes: "Test Notes" }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TacosController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      taco = Taco.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      taco = Taco.create! valid_attributes
      get :show, params: {id: taco.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Taco" do
        expect {
          post :create, params: {taco: valid_attributes}, session: valid_session
        }.to change(Taco, :count).by(1)
      end

      it "renders a JSON response with the new taco" do

        post :create, params: {taco: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new taco" do

        post :create, params: {taco: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end


  describe "DELETE #destroy" do
    it "destroys the requested taco" do
      taco = Taco.create! valid_attributes
      expect {
        delete :destroy, params: {id: taco.to_param}, session: valid_session
      }.to change(Taco, :count).by(-1)
    end
  end

end