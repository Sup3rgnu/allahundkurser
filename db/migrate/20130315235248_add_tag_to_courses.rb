class AddTagToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :tag_id, :integer
    add_index :courses, :tag_id
  end
end
