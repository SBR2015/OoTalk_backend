class Api::V1::LessonsController < ApplicationController
  #before_action :validate_admin, except: [:index, :show]
  before_action :set_course
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  
  # GET /api/v1/courses/:course_id/lessons
  # GET /api/v1/courses/:course_id/lessons.json
  def index
    @lessons = Lesson.where(:course_id => @course.id.to_s).order(:order)
    render "index", :formats => [:json], :handlers => [:jbuilder]
  end

  # GET /api/v1/courses/:course_id/lessons/1
  # GET /api/v1/courses/:course_id/lessons/1.json
  def show
  end

  # GET /api/v1/courses/:course_id/lessons/new
  def new
    @lesson = Lesson.new
  end

  # POST /api/v1/courses/:course_id/lessons.json
  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      render "show", :formats => [:json], :handlers => [:jbuilder]
    else
      render :json => {:error => @lesson.errors}
    end
  end

  # PATCH/PUT /api/v1/courses/:course_id/lessons/1.json
  def update
    if @lesson.update(lesson_params)
      render "show", :formats => [:json], :handlers => [:jbuilder]
    else
      render :json => {:error => @lesson.errors}
    end
  end

  # DELETE /api/v1/courses/:course_id/lessons/1.json
  def destroy
    @lesson.destroy
    render :json => {:status => 'deleted', :lesson => @lesson}
  end

  private
    def set_course
      @course = Course.find(params[:course_id])
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      lesson = Lesson.find(params[:id])
      @lesson = lesson if lesson.course_id == @course.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params[:lesson]
    end
end
