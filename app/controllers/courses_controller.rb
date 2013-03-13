class CoursesController < ApplicationController

	http_basic_authenticate_with :name => "admin", :password => "grolle", :only => :destroy

	# GET /orgs
	# GET /orgs.json
  	def index
    	@courses = Course.all

	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @courses }
	    end
	end

	def create 
		@org = Org.find(params[:org_id])
		@course = @org.courses.create(params[:course])
		redirect_to org_path(@org)
	end

	def new
	  	@org = Org.find(params[:org_id])
	    @course = Course.new

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @org }
	    end
	end

	def show
	    @course = Course.find(params[:id])
	    
	    respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @course }
	    end
	end


	def destroy
		@org = Org.find(params[:org_id])
		@course = @org.courses.find(params[:id])
		@course.destroy
		redirect_to org_path(@org)
	end

end
