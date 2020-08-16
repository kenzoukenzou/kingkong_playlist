require 'net/http'

class UploadVideosSecond

  def self.generate_end_point(page_token)
    "https://www.googleapis.com/youtube/v3/search?key=#{ENV['YOUTUBE_API_KEY']}&channelId=UCgm5JFYUWqVTQKH15D8eqFg&part=snippet,id&order=date&pageToken=#{page_token}&maxResults=40"
  end

  def self.execute
    puts 'バッチ処理を開始します。'
    
    begin
      page_tokens = ['CCgQAA'] # 最初のpageTokenを指定

      3.times do |n|
        end_point = UploadVideosSecond.generate_end_point(page_tokens.last)
        uri = URI(end_point)
        res = Net::HTTP.get_response(uri)
        results = JSON.parse(res.body)

        results['items'].each do |result|
          video = Video.new
          youtube_key = result['id']['videoId']
          video.save_with_youtube_data({ youtube_key: youtube_key })
        end

        page_tokens << results['nextPageToken']
      end
    rescue => e
      Rails.logger.error e.message
      puts 'バッチ処理に失敗しました。処理を見直してください。'
    end

    puts 'バッチ処理を終了します。'
  end
end
