require 'net/http'

class UploadVideos
  YOUTUBE_ENDPOINT = "https://www.googleapis.com/youtube/v3/search?key=#{ENV['YOUTUBE_API_KEY']}&channelId=UCgm5JFYUWqVTQKH15D8eqFg&part=snippet,id&order=date&maxResults=40"

  def self.execute
    puts 'バッチ処理を開始します。'

    begin
      uri = URI(YOUTUBE_ENDPOINT)
      res = Net::HTTP.get_response(uri)
      results = JSON.parse(res.body)
      results['items'].each do |result|
        video = Video.new
        youtube_key = result['id']['videoId']
        video.save_with_youtube_data({ youtube_key: youtube_key })
      end
    rescue => e
      Rails.logger.error e.message
      puts 'バッチ処理に失敗しました。処理を見直してください。'
    end

    puts 'バッチ処理を終了します。'
  end
end
