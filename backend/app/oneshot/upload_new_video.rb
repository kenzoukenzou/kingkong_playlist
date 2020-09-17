require 'net/http'

# 最新の動画1件取得保存する処理
# 毎週キングコングは毎週日曜日に投稿されるのでそのタイミングで走らせる
class UploadNewVideo
  YOUTUBE_ENDPOINT = "https://www.googleapis.com/youtube/v3/search?key=#{ENV['YOUTUBE_API_KEY']}&channelId=UCgm5JFYUWqVTQKH15D8eqFg&part=snippet,id&order=date&maxResults=1"

  def self.execute
    puts 'バッチ処理を開始します。'

    begin
      uri = URI(YOUTUBE_ENDPOINT)
      res = Net::HTTP.get_response(uri)
      results = JSON.parse(res.body)
      
      video = Video.new
      youtube_key = results['items'].first['id']['videoId']
      video.save_with_youtube_data({ youtube_key: youtube_key })
    rescue => e
      Rollbar.error(e)
      raise e
    end

    puts 'バッチ処理を終了します。'
  end
end