class V1::BookmarksController < ApplicationController
  def create
    bookmark = Bookmark.new(bookmark_params)
    if bookmark.save
      render json: bookmark, status: :created
    else
      render json: { errors: bookmark.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def bookmark_params
    params.require(:bookmark).permit(:video_id, :content)
  end
end
