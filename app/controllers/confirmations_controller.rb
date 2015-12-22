class ConfirmationsController < Devise::ConfirmationsController
  private

  def after_confirmation_path_for(resource_name, resource)
    if params[:redirect_url] && params[:redirect_url].length > 0
      params[:redirect_url]
    else
      super
    end
  end
end
