class RenameUrlToVideos < ActiveRecord::Migration[6.0]
  def change
    rename_column :videos, :url, :youtube_key
  end
end
