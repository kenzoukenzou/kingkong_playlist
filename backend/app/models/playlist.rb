# == Schema Information
#
# Table name: playlists
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :text
#  thumbnail   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Playlist < ApplicationRecord
  validates :title, presence: true
  has_many :bookmarks
  has_many :videos, through: :bookmarks

  def set_first_video_thumbnail
    update(thumbnail: videos.first.thumbnail)
  end
end
