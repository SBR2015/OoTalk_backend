require 'rails_helper'

RSpec.describe Api::V1::UseractivityController, type: :controller do
  before :each do
    @user = FactoryGirl.create(:user)
    @course = FactoryGirl.create(:course)
    @lesson = FactoryGirl.create(:lesson) 
  end
  # This should return the minimal set of attributes required to create a valid
  # Course. As you add validations to Course, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CoursesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns http success" do
      activity = Useractivity.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:activities)).to eq([activity])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      activity = Useractivity.create! valid_attributes
      get :show, {:id => activity.to_param}, valid_session
      expect(assigns(:activity)).to eq(activity)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Lesson" do
        expect {
          post :create, {:activity => valid_attributes}, valid_session
        }.to change(Useractivity, :count).by(1)
      end

      it "assigns a newly created api_v1 as @api_v1" do
        post :create, {:activity => valid_attributes}, valid_session
        expect(assigns(:activity)).to be_a(Useractivity)
        expect(assigns(:activity)).to be_persisted
      end

      it "redirects to the created api_v1" do
        post :create, {:activity => valid_attributes}, valid_session
        expect(response).to redirect_to(Useractivity.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved activity as @activity" do
        post :create, {:activity => invalid_attributes}, valid_session
        expect(assigns(:activity)).to be_a_new(Useractivity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested api_v1" do
        activity = Useractivity.create! valid_attributes
        put :update, {:id => activity.to_param, :activity => new_attributes}, valid_session
        activity.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested api_v1 as @api_v1" do
        activity = Useractivity.create! valid_attributes
        put :update, {:id => activity.to_param, :activi => valid_attributes}, valid_session
        expect(assigns(:api_v1)).to eq(activity)
      end

      it "redirects to the api_v1" do
        activity = Useractivity.create! valid_attributes
        put :update, {:id => activity.to_param, :activity => valid_attributes}, valid_session
        expect(response).to redirect_to(activity)
      end
    end

    context "with invalid params" do
      it "assigns the api_v1 as @api_v1" do
        activity = Useractivity.create! valid_attributes
        put :update, {:id => activity.to_param, :activity => invalid_attributes}, valid_session
        expect(assigns(:activity)).to eq(activity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested api_v1" do
      activity = Useractivity.create! valid_attributes
      expect {
        delete :destroy, {:id => activity.to_param}, valid_session
      }.to change(Useractivity, :count).by(-1)
    end
  end

end
