class Video < ApplicationRecord
    validates :title, :url,  presence: true
    has_and_belongs_to_many :tags, autosave: true
    has_and_belongs_to_many :comments, autosave: true
end
