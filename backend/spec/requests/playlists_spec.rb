require 'rails_helper'

describe "PlaylistAPI" do
  describe "index" do
    before {
      create_list(:playlist, 10)
    }
    subject { get v1_playlists_path } 
    it { is_expected.to eq 200 }
  end

  describe "show" do
    let!(:playlist) { create(:playlist, title: 'V1API_SHOW_TEST') }
    subject { get v1_playlist_path(playlist) }
    it { is_expected.to eq 200 }
  end
end
