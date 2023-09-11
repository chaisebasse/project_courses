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
    @order = if current_user.present?
               if @section
                 current_user.orders.find_or_create_by(purchasable: @section, state: 'pending')
               else
                 current_user.orders.find_or_create_by(purchasable: @course, state: 'pending')
               end
             end
    authorize @course
  end

  def new
    @course = Course.new
    authorize @course
  end

  def create
    chosen_color = params[:course][:color]
    user_colors = {
      'User 1' => 'rgb(255, 152, 72)',
      'User 2' => '#5CB8E4',
      'Other' => 'green'
    }

    @course = Course.new(course_params)
    @course.price_cents = params[:course][:price_cents]
    @course.color = user_colors[chosen_color]
    @course.save
    if @course.save
      redirect_to new_section_path(course_title: @course.title),
                  notice: 'Bonjour'
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
    params.require(:course).permit(:title, :price_cents)
  end

  def authorize_user!
    authorize Course, :admin?
  end
end
