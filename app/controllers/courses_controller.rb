class CoursesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :authorize_user!, except: %i[index show]

  def index
    @courses = policy_scope(Course)
    @courses = Course.all
  end

  def show
    @course = policy_scope(Course)
    @course = Course.find(params[:id])
    authorize @course
  end

  def new
    @course = Course.ne
    authorize @course
  end

  def create
    @course = Course.new(course_params)
    @course.save
    if @course.save
      redirect_to course_path(@course)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    @course.update(course_params)
    redirect_to course_path(@course)
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit(:title)
  end

  def authorize_user!
    authorize Course, :admin?
  end
end
