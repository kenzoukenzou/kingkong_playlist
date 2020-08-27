# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#

FactoryBot.define do
  factory :user do
    email { "MyString" }
  end
end