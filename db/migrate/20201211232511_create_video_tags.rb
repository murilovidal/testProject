class CreateVideoTags < ActiveRecord::Migration[6.0]
  def change
    create_join_table :videos, :tags
  end
end
