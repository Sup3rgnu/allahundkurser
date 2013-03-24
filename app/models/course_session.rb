class CourseSession < ActiveRecord::Base
  belongs_to :course
  attr_accessible :end, :start
end
