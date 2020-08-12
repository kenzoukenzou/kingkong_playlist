class V1::BookmarksController < ApplicationController
  before_action :set_bookmark, only: :destroy

  def create
    bookmark = Bookmark.new(bookmark_params)
    
    if bookmark.save
      bookmark.playlist.set_first_video_thumbnail if bookmark.playlist.present?
      render json: bookmark, status: :created
    else
      render json: { errors: bookmark.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
  end

  private
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end

    def bookmark_params
      params.require(:bookmark).permit(:video_id, :content, :time, :playlist_id)
    end
end
