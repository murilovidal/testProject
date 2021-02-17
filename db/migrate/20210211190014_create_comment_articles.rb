class CreateCommentArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_articles do |t|
      t.text :body
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
