class Api::V1::ExecuteController < Api::V1::BaseController
  protect_from_forgery :except => [:create]
  def index

  end

  def create
    setcode
    src = @code['src']

    if user_signed_in?
      newcode = Code.new
      newcode.user_id = current_user.id
      newcode.code = src
      newcode.save
    end

    prog = Program.new(src)
    render :json => prog.exec.to_json
  end

  private

  def setcode
    @code = params[:code]
  end
end
