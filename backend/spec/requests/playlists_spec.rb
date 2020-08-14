require 'rails_helper'

describe "PlaylistAPI" do
  describe "index" do
    before {
      create_list(:playlist, 10)
    }
    it do
      get v1_playlists_path
      expect(response.status).to eq 200
    end
  end

  describe "show" do
    let!(:playlist) { create(:playlist, title: 'V1API_SHOW_TEST') }
    it do
      get v1_playlist_path(playlist)
      expect(response.status).to eq 200
    end
    it 'レスポンスがプレイリストタイトルを含んでいること' do
      get v1_playlist_path(playlist)
      expect(response.body).to include 'V1API_SHOW_TEST'
    end
  end
end
