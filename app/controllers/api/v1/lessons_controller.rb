class Api::V1::LessonsController < ApplicationController
  #before_action :validate_admin, except: [:index, :show]
  before_action :set_course
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/courses/:course_id/lessons
  # GET /api/v1/courses/:course_id/lessons.json
  def index
    @lessons = Lesson.where(:course_id => @course.id.to_s)
  end

  # GET /api/v1/courses/:course_id/lessons/1
  # GET /api/v1/courses/:course_id/lessons/1.json
  def show
  end

  # GET /api/v1/courses/:course_id/lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET /api/v1/courses/:course_id/lessons/1/edit
  def edit
  end

  # POST /api/v1/courses/:course_id/lessons
  # POST /api/v1/courses/:course_id/lessons.json
  def create
    @lesson = Lesson.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/v1/courses/:course_id/lessons/1
  # PATCH/PUT /api/v1/courses/:course_id/lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(api_v1_lesson_params)
        format.html { redirect_to @api_v1_lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/courses/:course_id/lessons/1
  # DELETE /api/v1/courses/:course_id/lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to api_v1_lessons_url, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
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
