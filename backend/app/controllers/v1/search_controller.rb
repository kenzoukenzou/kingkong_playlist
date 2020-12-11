class V1::SearchController < ApplicationController
  def index
    @videos = Video.where('title like ?', "%#{params[:query]}%").order(:id)

    render json: [
      videos: @videos.as_json(include: :bookmarks)
    ]
  end
end
