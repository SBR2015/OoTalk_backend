require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "GET #profile" do
    context 'login user' do
      login_user
      it "returns http success" do
        get :profile, {}
        expect(response).to have_http_status(:success)
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
