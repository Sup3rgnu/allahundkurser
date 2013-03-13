class Course < ActiveRecord::Base
  belongs_to :org

  attr_accessible :name, :price, :city, :province, :category

  validates :name, :presence => true

end

