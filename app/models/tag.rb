class Tag < ActiveRecord::Base
  attr_accessible :name, :id
  has_many :course_tags
  has_many :courses, :through => :course_tags

  def self.search(search)
  	if search
  		str = "%#{search.downcase}%"
      where('LOWER (name) LIKE ? ', str)
    else 
  		scoped
  	end
  end
end
