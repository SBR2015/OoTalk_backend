require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "GET #profile" do
    context 'login user' do
      it "returns http success" do
        user = FactoryGirl.create(:user)
        user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are      using the confirmable module
        sign_in user

        get :profile, {}
        expect(response).not_to have_http_status(:success)
      end
    end

    context 'non-login user' do
      it "returns http non-success" do
        get :profile, {}
        expect(response).not_to have_http_status(:success)
      end
    end
  end
end
