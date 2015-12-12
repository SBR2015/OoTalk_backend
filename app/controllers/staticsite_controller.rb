class StaticsiteController < ApplicationController
  def index
    if user_signed_in?
      redirect_to code_path
    end
  end

  def about
  end
end
