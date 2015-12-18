class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery unless: -> { request.format.json? }

  def validate_admin
    if current_user.nil? or !current_user.admin?
      head :unauthorized
      false
    end
  end

  before_action :set_locale

  def default_url_options(options = {})
    { lang: I18n.locale }.merge options
  end

  def set_locale
    I18n.locale = params[:lang] || I18n.default_locale
  end
end

