class CreateCourseTags < ActiveRecord::Migration
  def change
    create_table :course_tags do |t|
      t.references :course
      t.references :tag

      t.timestamps
    end
  end
end
