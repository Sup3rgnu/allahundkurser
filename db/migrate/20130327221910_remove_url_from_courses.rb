class RemoveUrlFromCourses < ActiveRecord::Migration
  def up
  	remove_column :courses, :url
  end

  def down
  	add_column :courses, :url, :string
  end
end
