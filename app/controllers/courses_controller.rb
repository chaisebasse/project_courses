class CoursesController < ApplicationController
  def index
    @courses = policy_scope(Course)
    @courses = Course.all
    authorize @courses
  end

  def show
    @course = policy_scope(Course)
    @course = Course.find(params[:id])
    authorize @course
  end

  def new
    @course = Course.new(course_params)
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
end
