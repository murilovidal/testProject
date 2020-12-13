class Comment < ApplicationRecord
    has_and_belongs_to_many :articles
    has_and_belongs_to_many :videos
    has_and_belongs_to_many :users
    validates :comment, presence: true
end
