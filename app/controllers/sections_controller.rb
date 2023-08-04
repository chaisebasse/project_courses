class SectionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :authorize_user!, except: %i[index show]

  def show
    @section = Section.find(params[:id])

    @course = @section.course
    @order = @section.orders.find_or_initialize_by(user: current_user, state: 'pending')

    authorize @section

    @order.save
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    @course = @section.course
    @course.save
    @section.save
    if @section.save
      redirect_to section_path(@section)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    @section.update(section_params)
    redirect_to section_path(@section)
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    redirect_to sections_path
  end

  private

  def section_params
    params.require(:section).permit(:title, :course_id)
  end

  def authorize_user!
    authorize Section, :admin?
  end
end
