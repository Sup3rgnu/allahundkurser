class HomeController < ApplicationController
  def index
	@courses = Course.find(:all, :order => "id desc", :limit => 10)
	@locations = Location.all
	@courseTags = CourseTag.all 

	# Filter on provinces 
	@courses = @courses.select { |c| c.province == params[:province_filter] } if !params[:province_filter].blank?

	# Filter on tags
	@matches = Array.new
	@courseTags.each do |ct|
		@matches.push ct.course_id if ct.tag_id == params[:tag_filter].to_i
	end
	@courses = @courses.select { |c| @matches.include? c.id } if !params[:tag_filter].blank?

    respond_to do |format|
    	format.html # show.html.erb
		format.json { render :json => { :courses => @courses, :locations => @locations}}
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