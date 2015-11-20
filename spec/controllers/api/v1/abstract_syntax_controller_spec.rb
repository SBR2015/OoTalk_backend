require 'rails_helper'

RSpec.describe Api::V1::AbstractSyntaxController, type: :controller do

  describe "GET #show" do
    it "should be able to success" do
      expect(get :show, {language: :ja}).to have_http_status(:success)
      expect(get :show, {language: :ar}).to have_http_status(:success)
    end
  end

end
