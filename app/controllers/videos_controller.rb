class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])
    authorize @video
  end

  def new
    @video = Video.new
    authorize @video
  end

  def create
    @video = Video.new(video_params)
    @section = @video.section
    @section.save
    @video.save
    if @video.save
      redirect_to video_path(@video)
    else
      render :new, status: :unprocessable_entity
    end
    authorize @video
  end

  def edit
    @video = Video.find(params[:id])
    authorize @video
  end

  def update
    @video = Video.find(params[:id])
    @video.update(video_params)
    redirect_to video_path(@video)
    authorize @video
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to videos_path
    authorize @video
  end

  private

  def video_params
    params.require(:video).permit(:name, :section_id, :video)
  end
end
