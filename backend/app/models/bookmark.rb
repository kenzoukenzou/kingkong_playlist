# == Schema Information
#
# Table name: bookmarks
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  video_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  time       :float
#

class Bookmark < ApplicationRecord
  validates :content, presence: true
  belongs_to :video
end
