class Video < ApplicationRecord
  validates :title, :youtube_key, presence: true
end
