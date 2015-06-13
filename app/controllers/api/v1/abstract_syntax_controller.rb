class Api::V1::AbstractSyntaxController < ApplicationController
  def index
    @asl = AbstractSyntaxLists.create(:en)
    render :json => @asl.to_json
  end

  def show
    @asl = AbstractSyntaxLists.create(params[:language])
    render :json => @asl.to_json
  end
end
