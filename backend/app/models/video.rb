# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  youtube_key :string           not null
#  thumbnail   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  embed_url   :string
#

class Video < ApplicationRecord
  validates :title, :youtube_key, presence: true
end
