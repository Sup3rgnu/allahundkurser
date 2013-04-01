class Org < ActiveRecord::Base
  attr_accessible :description, :name, :url, :user_id
  validates :name, :presence => true
  has_many :courses, :dependent => :destroy
  belongs_to :user
end
