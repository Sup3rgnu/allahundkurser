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
		
		(1..params[:sessions].to_i).each do |s|
			@course_session = CourseSession.new
			@course_session.course_id = @course.id
			@course_session.save
		end	

		@tags = Tag.find(params[:course_category])
	    
	    # Add new tags    
    	@tags.each do |tag|
			@course_tag = CourseTag.new
			@course_tag.tag_id = tag.id
			@course_tag.course_id = @course.id
			@course_tag.save   			
    	end

		redirect_to org_path(@org)
	end

	def new
	  	@org = Org.find(params[:id])
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
    	# Get the associated course sessions
    	@course_sessions = CourseSession.where("course_id = ?", params[:id])
    	# Get the tags that are currently selected
    	@active_tags = CourseTag.select("tag_id").where("course_id = ?", params[:id]).map { |t| t.tag_id }

  	end

  	def update
    	@course = Course.find(params[:id])    	

		@course_sessions = CourseSession.where("course_id = ?", params[:id])
		@course_sessions.each do |cs|
			cs.destroy
		end
		
		count = params[:course][:sessions]
		sessions_start = params[:session_date_start]
		sessions_end = params[:session_date_end]


		(1..count.to_i).each do |s|
			@session = CourseSession.new
			@session.course_id = params[:id]
			
			if sessions_start && sessions_end
				@session.start = create_date(flatten_date_array(sessions_start, s, 'start'))
				@session.end = create_date(flatten_date_array(sessions_end, s, 'end'))
			else
				@session.start = DateTime.now + 30
				@session.end = DateTime.now + 30
			end
			@session.save
		end	

		@course_tags = CourseTag.where("course_id = ?", params[:id])
		# Remove old tags
		@course_tags.each do |ct| 
			ct.destroy
		end

		if (params.has_key?(:category_id))
    		@tags = Tag.find(params[:category_id])
    	
			# Add new tags    
	    	@tags.each do |tag|
				@course_tag = CourseTag.new
				@course_tag.tag_id = tag.id
				@course_tag.course_id = @course.id
				@course_tag.save   			
	    	end   
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

  	def flatten_date_array(hash, n, type)
  		%w(1 2 3 4 5).map { |e| hash["#{type}#{n}(#{e}i)"].to_i }
	end

	def create_date(values)
		DateTime.new values[0], values[1], values[2], values[3], values[4]
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

	def getCourseCoords
		@course = Course.find(params[:id])
    	@marker = Array.new
    	@marker.push @course
    	@marker.push Location.find(@course.location_id)
	    
	    respond_to do |format|
	    	format.json { render json: @marker }
	    end
	  end  

end
