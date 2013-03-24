class CreateCourseSessions < ActiveRecord::Migration
  def change
    create_table :course_sessions do |t|
      t.datetime :start
      t.datetime :end
      t.references :course

      t.timestamps
    end
    add_index :course_sessions, :course_id
  end
end
