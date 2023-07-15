class SectionsController < ApplicationController
  def show
    @section = Section.find(params[:id])
    @course = @section.course
    authorize @section
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    @course = @section.course
    @course.save
    @section.save
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    @section.update(section_params)
    redirect_to course_path(@section)
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    redirect_to sections_path
  end

  private

  def section_params
    params.require(:section).permit(:title)
  end
end
