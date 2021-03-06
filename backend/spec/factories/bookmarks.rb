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

FactoryBot.define do
  factory :bookmark do
    content { '天才的な梶原のボケ' }
    time { 10.0 }
  end
end
