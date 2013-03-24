class AddSessionsToCourses < ActiveRecord::Migration
  def change
  	add_column :courses, :sessions, :integer
  end
end
