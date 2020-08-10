# == Schema Information
#
# Table name: videos
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  youtube_key  :string           not null
#  thumbnail    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  embed_url    :string
#  published_at :datetime
#

class Video < ApplicationRecord
  validates :title, :youtube_key, presence: true
  validates :youtube_key, uniqueness: true
  has_many :bookmarks, -> { order(:time) }, dependent: :destroy

  require 'net/http'
  YOUTUBE_ENDPOINT = 'https://www.googleapis.com/youtube/v3/videos'
  YOUTUBE_PARAMS = { part: 'snippet', type: 'video', key: ENV['YOUTUBE_API_KEY'] }

  def save_with_youtube_data(params)
    ActiveRecord::Base.transaction do
      assign_attributes(params)
      result_hash = fetch_youtube_api
      set_video_data(result_hash)
      save
    end
  end

  private
    def fetch_youtube_api
      uri = URI(YOUTUBE_ENDPOINT)
      params = YOUTUBE_PARAMS.merge(id: youtube_key)

      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      JSON.parse(res.body)
    end

    def set_video_data(result_hash)
      return if result_hash['items'].blank?

      self.title = result_hash['items'][0]['snippet']['title']
      self.thumbnail = result_hash['items'][0]['snippet']['thumbnails']['medium']['url']
      self.embed_url = "https://www.youtube.com/embed/#{self.youtube_key}"
      self.published_at = result_hash['items'][0]['snippet']['publishedAt']
    end
end
