class SectionsController < ApplicationController
  def show
    @section = Section.find(params[:id])
    @course = @section.course
    authorize @section
  end

  def new
    @section = Section.new
    authorize @section
  end

  def create
    @section = Section.new(section_params)
    @course = @section.course
    @course.save
    @section.save
    authorize @section
  end

  def edit
    @section = Section.find(params[:id])
    authorize @section
  end

  def update
    @section = Section.find(params[:id])
    @section.update(section_params)
    redirect_to section_path(@section)
    authorize @section
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    redirect_to sections_path
    authorize @section
  end

  private

  def section_params
    params.require(:section).permit(:title, :course_id)
  end
end
