class Api::V1::AbstractSyntaxController < ApplicationController
  def index
  end

  def show
    @asl = AbstractSyntaxLists.create(params[:language])
    render :json => @asl.to_json
  end
end
