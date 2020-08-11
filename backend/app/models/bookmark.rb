# == Schema Information
#
# Table name: bookmarks
#
#  id          :integer          not null, primary key
#  content     :text             not null
#  video_id    :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  time        :float
#  playlist_id :integer
#

class Bookmark < ApplicationRecord
  validates :content, presence: true
  belongs_to :video
  belongs_to :playlist
end
