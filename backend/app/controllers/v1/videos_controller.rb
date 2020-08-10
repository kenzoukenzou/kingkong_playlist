class V1::VideosController < ApplicationController
  before_action :set_video, only: %i[show destroy]

  def index
    videos = Video.order(:id)
    render json: videos
  end

  def show
    render json: @video, include: ['bookmarks']
  end

  def create
    video = Video.new(video_params)
    if video.save_with_youtube_data(video_params)
      render json: video, status: :created
    else
      render json: { errors: video.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @video.destroy
  end

  private
    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:youtube_key)
    end
end
