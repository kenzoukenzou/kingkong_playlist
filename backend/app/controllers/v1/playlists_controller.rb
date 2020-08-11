class V1::PlaylistsController < ApplicationController
  before_action :set_playlist, only: :destroy

  def create
    playlist = Playlist.new(playlist_params)
    if playlist.save
      render json: playlist, status: :created
    else
      render json: { errors: playlist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    def playlist_params
      params.require(:playlist).permit(:title)
    end
end
