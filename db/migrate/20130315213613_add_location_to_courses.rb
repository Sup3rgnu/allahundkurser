class AddLocationToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :location_id, :integer
    add_index :courses, :location_id
  end
end
