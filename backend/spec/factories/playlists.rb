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

FactoryBot.define do
  factory :playlist do
    title { '梶原工業どんがらがっしゃん珍道中' }
    description { '梶原工業がロレックスを買う話' }
    thumbnail { 'https://i.ytimg.com/vi/HcFrYRFu2-w/mqdefault.jpg' }
  end
end
