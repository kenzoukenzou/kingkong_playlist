class V1::PlaylistsController < ApplicationController
  before_action :set_playlist, only: %i[destroy show]

  def index
    render json: [
      all_playlists: Playlist.order(:id),
      have_bookmarks_playlists: Playlist.joins(:bookmarks).order(:id).distinct
    ]
  end

  def show
    render json: [
      playlist: @playlist.as_json(include: [:videos, bookmarks: { include: [:video] }]),
    ]
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
