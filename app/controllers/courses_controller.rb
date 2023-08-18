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
    @section = Section.find(params[:section_id]) if params[:section_id].present?

    # Check if a section is selected, and create or find an order for the selected section
    @order = if @section
               current_user.orders.find_or_create_by(purchasable: @section, state: 'pending')
             else
               current_user.orders.find_or_create_by(purchasable: @course, state: 'pending')
             end
    authorize @course
  end

  def new
    @course = Course.new
    @section = @course.sections.build
    @section.videos.build
    authorize @course
  end

  def create
    @course = Course.new(course_params)
    @course.price_cents = params[:course][:price_cents]
    @course.save
    if @course.save
      flash.alert = 'Course was successfully created.'
      puts "PRICE PRICE#{@course.price_cents}"
    else
      puts @course.errors.full_messages
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
    params.require(:course).permit(:title, :price_cents, sections_attributes: [:id, :title, :price_cents, :description, { videos_attributes: %i[id name video] }])
  end

  def authorize_user!
    authorize Course, :admin?
  end
end
