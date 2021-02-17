class Article < ApplicationRecord
  has_many :comment_articles, dependent: :delete_all
  validates :body, :title, :presence => true
end
