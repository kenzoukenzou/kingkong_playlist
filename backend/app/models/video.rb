class Video < ApplicationRecord
  validates :title, :url, presence: true
end
