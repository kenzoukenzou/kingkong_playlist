class V1::PlaylistsController < ApplicationController
  before_action :set_playlist, only: %i[destroy show]

  def index
    playlists = Playlist.order(:id)
    render json: playlists
  end

  def show
    render json: @playlist, include: [:videos, bookmarks: { include: [:video] }]
  end

  def create
    playlist = Playlist.new(playlist_params)
    if playlist.save
      render json: playlist, status: :created
    else
      render json: { errors: playlist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @playlist.destroy
  end

  private
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    def playlist_params
      params.require(:playlist).permit(:title)
    end
end
