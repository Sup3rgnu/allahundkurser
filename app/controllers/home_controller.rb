class HomeController < ApplicationController
  def index
	@courses = Course.find(:all, :order => "id desc", :limit => 10) 
    respond_to do |format|
    	format.html # show.html.erb
		format.json { render json: @courses }
	end
  end

  def getCoords
	@courses = Course.find(:all, :order => "id desc", :limit => 10) 
	@mapObjects = Array.new

	@courses.each do |course|
		@object = Array.new
		@object.push course
		@object.push Location.find(course.location_id)		 
		@mapObjects.push @object
	end	

    respond_to do |format|
		format.json { render json: @mapObjects }
	end
  end

end