require 'rails_helper'

RSpec.describe Api::V1::AbstractSyntaxController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

  end

  describe "GET #show" do
    it "should be able to success" do
      expect(get :show, {language: :ja}).to have_http_status(:success)
    end

    it "shouldn't be able to success" do
      expect{get :show, {language: :ar}}.to raise_error(I18n::InvalidLocale)
    end

  end

end
