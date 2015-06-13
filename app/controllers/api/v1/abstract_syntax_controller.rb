class Api::V1::AbstractSyntaxController < ApplicationController
  def index
  end

  def show
    @asl = OoTalk::AbstractSyntaxLists.create(params[:language])
    render :json => @asl.to_json
  end
end
