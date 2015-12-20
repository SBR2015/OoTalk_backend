class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate_user!
  before_action :setuser
  
  def profile
    render "profile", :formats => [:json], :handlers => [:jbuilder]
  end

  def code
    render "code", :formats => [:json], :handlers => [:jbuilder]
  end

  private

  def setuser
    @user = current_user
    @codes = @user.codes
  end

end
