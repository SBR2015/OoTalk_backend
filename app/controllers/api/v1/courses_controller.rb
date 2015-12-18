class Api::V1::CoursesController < Api::V1::BaseController
  before_action :validate_admin, except: [:index, :show]
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.all
    render "index", :formats => [:json], :handlers => [:jbuilder]
  end

  def show
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      render "show", :formats => [:json], :handlers => [:jbuilder]
    else
      render :json => {:error => @lesson.errors}
    end
  end

  def update
    if @course.save
      render "show", :formats => [:json], :handlers => [:jbuilder]
    else
      render :json => {:error => @lesson.errors}
    end
  end

  def destroy
    @course.destroy
    render :json => {:status => 'deleted', :course => @course}
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
