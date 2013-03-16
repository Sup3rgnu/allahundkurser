class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :course_tags
  has_many :courses, :through => :course_tags
end
