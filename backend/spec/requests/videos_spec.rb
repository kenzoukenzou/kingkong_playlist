require 'rails_helper'

describe "VideoAPI" do
  describe "index" do
    before {
      create_list(:video, 10)
    }
    subject { get v1_videos_path } 
    it { is_expected.to eq 200 }
  end

  describe "show" do
    let!(:video) { create(:video, title: 'V1API_SHOW_TEST') }
    subject { get v1_video_path(video) }
    it { is_expected.to eq 200 }
  end
end
