class CreateVideosComments < ActiveRecord::Migration[6.0]
  def change
    create_join_table :videos, :comments
  end
end
