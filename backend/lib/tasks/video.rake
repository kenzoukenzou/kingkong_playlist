namespace :video do
  desc "毎週日曜日に投稿されるYoutube動画を登録する"
  task :upload_video do
    UploadNewVideo.execute
  end
end
