class AddUrlToCourses < ActiveRecord::Migration
  def change
  	add_column :courses, :url, :string
  	add_column :courses, :desc, :text
  end
end
