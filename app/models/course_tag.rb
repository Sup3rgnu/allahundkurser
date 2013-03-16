class CourseTag < ActiveRecord::Base
  attr_accessible :course_id, :tag_id
  belongs_to :course
  belongs_to :tag
end
