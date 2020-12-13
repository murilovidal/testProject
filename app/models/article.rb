class Article < ApplicationRecord
    validates :title, :body,  presence: true
    has_and_belongs_to_many :tags, autosave: true
    has_and_belongs_to_many :comments, autosave: true
    default_scope { order(created_at: :desc) }


    def self.search(query)
        if query
            tag = Tag.find_by(tag: query)
            if tag
                Article.includes(:tags).where("tags.tag= '#{tag.tag}'").references(:tags)
            else
                nil #Quando nada encontrado
            end
        else
            nil #Quando não foi feita pesquisa
        end
    end
end
