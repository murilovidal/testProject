class Article < ApplicationRecord
    validates :title, :body,  presence: true
    has_and_belongs_to_many :tags, autosave: true
end
