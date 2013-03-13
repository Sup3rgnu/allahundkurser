class Org < ActiveRecord::Base
  attr_accessible :description, :name

  validates :name, :presence => true

  has_many :courses, :dependent => :destroy
end
