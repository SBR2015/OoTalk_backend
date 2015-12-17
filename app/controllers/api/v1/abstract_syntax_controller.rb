class Api::V1::AbstractSyntaxController < Api::V1::BaseController

  def show
    @asl = Ootalk::Syntaxlist.create(params[:language])
    render json: @asl.to_json
  end

end
