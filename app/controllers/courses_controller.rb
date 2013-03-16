class CoursesController < ApplicationController

	http_basic_authenticate_with :name => "admin", :password => "grolle", :only => :destroy

	# GET /orgs
	# GET /orgs.json
  	def index
    	@courses = Course.all

	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @courses}
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
	    @locations = Location.all

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render :json => { :org => @org, :locations => @locations }}
	    end
	end
  	
  	def edit
    	@course = Course.find(params[:id])
    	@locations = Location.all
    	@tags = Tag.all
    	
    	# Get the tags that are currently selected
    	@active_tags = CourseTag.select("tag_id").where("course_id = ?", params[:id]).map { |t| t.tag_id }

  	end

  	def update
    	@course = Course.find(params[:id])    	
    	@tags = Tag.find(params[:category_id])    	
		@course_tags = CourseTag.where("course_id = ?", params[:id])

		# Remove old tags
		@course_tags. each do |ct| 
			ct.destroy
		end

		# Add new tags    
    	@tags.each do |tag|
			@course_tag = CourseTag.new
			@course_tag.tag_id = tag.id
			@course_tag.course_id = @course.id
			@course_tag.save   			
    	end     	

    	respond_to do |format|
    	  if @course.update_attributes(params[:course])
        	format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        	format.json { head :no_content }
      	else
        	format.html { render action: "edit" }
        	format.json { render json: @course.errors, status: :unprocessable_entity }
      	end
    	end
  	end

	def show
	    @course = Course.find(params[:id])	    

	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @course}
	    end
	end


	def destroy
		@org = Org.find(params[:org_id])
		@course = @org.courses.find(params[:id])
		@course.destroy
		redirect_to org_path(@org)
	end

end
