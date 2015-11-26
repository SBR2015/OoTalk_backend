class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def validate_admin
    if current_user.nil? or !current_user.admin?
      head :unauthorized
      false
    end
  end
end
