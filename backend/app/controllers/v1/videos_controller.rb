class V1::VideosController < ApplicationController
  before_action :set_video, only: :show

  def index
    videos = Video.order(:id)
    render json: videos
  end

  def show
    render json: @video
  end

  private
    def set_video
      @video = Video.find(params[:id])
    end
end
