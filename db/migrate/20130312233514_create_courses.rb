class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :price
      t.string :city
      t.string :province
      t.string :category
      t.references :org

      t.timestamps
    end
    add_index :courses, :org_id
  end
end
