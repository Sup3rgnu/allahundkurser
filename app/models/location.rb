class Location < ActiveRecord::Base
  attr_accessible :lat, :lng, :name, :id
  has_many :courses
end
