class Api::V1::DemoController < ApplicationController
  before_action :set_demo, only: [:show, :update, :destroy]

  # GET /api/v1/demos
  # GET /api/v1/demos.json
  def index
    @demos = Demo.all

    render json: @demos
  end

  # GET /api/v1/demos/1
  # GET /api/v1/demos/1.json
  def show
    render json: @demo
  end

  # POST /api/v1/demos
  # POST /api/v1/demos.json
  def create
    @demo = Demo.new(demo_params)

    if @demo.save
      render json: @demo, status: :created
    else
      render json: @demo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/demos/1
  # PATCH/PUT /api/v1/demos/1.json
  def update
    @demo = Demo.find(params[:id])

    if @demo.update(demo_params)
      head :no_content
    else
      render json: @demo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/demos/1
  # DELETE /api/v1/demos/1.json
  def destroy
    @demo.destroy

    head :no_content
  end

  private

  def set_demo
    @demo = Demo.find(params[:id])
  end

  def demo_params
    params.require(:demo).permit(:name, :duedate)
  end
end
