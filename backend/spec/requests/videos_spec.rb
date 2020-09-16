require 'rails_helper'

describe "VideoAPI" do
  describe "index" do
    before {
      create_list(:video, 10)
    }
    it do
      get v1_videos_path
      expect(response.status).to eq 200
    end
  end

  describe "show" do
    let!(:video) { create(:video, title: 'V1API_SHOW_TEST') }
    it do
      get v1_video_path(video)
      expect(response.status).to eq 200
    end
    it 'レスポンスが動画タイトルを含んでいること' do
      get v1_video_path(video)
      expect(response.body).to include 'V1API_SHOW_TEST'
    end
  end
end
