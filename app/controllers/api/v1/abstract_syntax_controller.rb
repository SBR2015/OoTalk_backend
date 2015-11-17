class Api::V1::AbstractSyntaxController < ApplicationController

  def show
    @asl = AbstractSyntaxLists.create(params[:language])
    render json: @asl.to_json
  end

end
