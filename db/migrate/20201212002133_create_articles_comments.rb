class CreateArticlesComments < ActiveRecord::Migration[6.0]
  def change
    create_join_table :articles, :comments
  end
end
