class CreateCommentsUsers < ActiveRecord::Migration[6.0]
  def change
    create_join_table :comments, :users
  end
end
