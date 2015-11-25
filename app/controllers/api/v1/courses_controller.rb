class Api::V1::CoursesController < ApplicationController
  before_action :validate_admin, except: [:index, :show]
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/courses
  # GET /api/v1/courses.json
  def index
    @courses = Course.all
  end

  # GET /api/v1/courses/1
  # GET /api/v1/courses/1.json
  def show
  end

  # GET /api/v1/courses/1/edit
  def edit
  end

  # POST /api/v1/courses
  # POST /api/v1/courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @api_v1_course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/v1/courses/1
  # PATCH/PUT /api/v1/courses/1.json
  def update
    respond_to do |format|
      if @api_v1_course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @api_v1_course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/courses/1
  # DELETE /api/v1/courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to api_v1_courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params[:course]
  end
end
