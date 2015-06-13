class Api::V1::AbstractSyntaxController < ApplicationController
  def index
    @asl = AbstractSyntaxLists.create(:ja)
    render :json => @asl.to_json
  end
end
