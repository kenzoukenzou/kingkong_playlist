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
  DISPLAY_NUM = 10
  validates :title, presence: true
  has_many :bookmarks
  has_many :videos, -> { distinct }, through: :bookmarks

  scope :have_bookmarks, -> { joins(:bookmarks).distinct }

  def others
    Playlist.have_bookmarks.where.not(id: id).first(DISPLAY_NUM)
  end

  def set_first_video_thumbnail
    update(thumbnail: videos.first.thumbnail)
  end
end
