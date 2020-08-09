class V1::VideosController < ApplicationController
  def index
    videos = Video.order(:id)
    render json: videos
  end
end
