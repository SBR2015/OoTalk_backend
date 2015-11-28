class Api::V1::UseractivityController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  
  def index
    @activities = UserActivity.all
  end

  def show
  end

  def create
    @activity = UserActivity.new(activity_params)
    respond_to do |format|
      if @activity.save
        format.json { render :show, status: :created, location: @activity }
      else
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.json { render :show, status: :ok, location: @activity }
      else
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @activity.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
  private
  
  def set_activity
    @activity = UserActivity.find(params[:id])
  end
  
  def activity_params
    params[:useractivity]
  end
end
