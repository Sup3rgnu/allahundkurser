class Course < ActiveRecord::Base
  belongs_to :org
  belongs_to :location
  has_many :course_tags
  has_many :tags, :through => :course_tags
  attr_accessible :name, :price, :city, :province, :category, :location_id
  validates :name, :presence => true
end

