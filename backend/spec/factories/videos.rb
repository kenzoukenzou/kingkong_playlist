# == Schema Information
#
# Table name: videos
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  youtube_key  :string           not null
#  thumbnail    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  embed_url    :string
#  published_at :datetime
#

FactoryBot.define do
  factory :video do
    title { '【衝撃】ロレックスからの…' }
    youtube_key { 'HcFrYRFu2-w' }
    thumbnail { 'https://i.ytimg.com/vi/HcFrYRFu2-w/mqdefault.jpg' }
    published_at { Time.zone.now }
  end
end
