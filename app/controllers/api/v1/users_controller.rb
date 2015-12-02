class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def profile
    @user = current_user
    render "profile", :formats => [:json], :handlers => [:jbuilder]
  end
end
