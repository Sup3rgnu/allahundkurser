# coding: utf-8
class Course < ActiveRecord::Base
  belongs_to :org
  belongs_to :location
  has_many :course_tags
  has_many :course_sessions
  has_many :tags, :through => :course_tags
  attr_accessible :name, :price, :city, :province, :location_id, :sessions, :participants, :desc
  validates :name, :presence => true

  def self.search(search)
  	if search
  		str = "%#{search.downcase}%"
      where('LOWER (name) LIKE ? OR LOWER (city) LIKE ? OR LOWER (province) LIKE ?', str, str, str)
    else 
  		scoped
  	end
  end

  def self.provinces
    ['Blekinge',
    'Dalarna',
    'Gotland',
    'Gävleborg',
    'Halland',
    'Jämtland',
    'Jönköping',
    'Kalmar',
    'Kronoberg',
    'Norrbotten',
    'Skåne',
    'Stockholm',
    'Södermanland',
    'Uppsala',
    'Värmland',
    'Västerbotten',
    'Västernorrland',
    'Västmanland',
    'Västra Götaland',
    'Örebro',
    'Östergötland'] 
  end

end

