class CreateArticlesTags < ActiveRecord::Migration[6.0]
  def change
    create_join_table :articles, :tags
  end
end
