class CourseTag < ActiveRecord::Base
  attr_accessible :course_id, :tag_id, :id
  belongs_to :course
  belongs_to :tag
end
