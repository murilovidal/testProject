class Video < ApplicationRecord
  has_many :comment_videos, dependent: :delete_all
  validates :title, :url, :presence => true
end
