class CoursesController < ApplicationController

	# before_filter :authenticate_user!, :except => [:show, :index]
	load_and_authorize_resource :except => [:getCourseCoords]

	# GET /orgs
	# GET /orgs.json
  	def index
    	@courses = Course.search(params[:search])
    	
    	if (params.has_key?(:search))
    		@tag = Tag.search(params[:search])

    		if @tag.exists?
	    		@ct = CourseTag.where('tag_id = ? ', @tag.first.id)

	    		@ct.each do |c|
	    			@courses.push Course.find(c.course_id)
	    		end
    		end

    	end

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
			@course_session.start = DateTime.now
			@course_session.end = DateTime.now			
			@course_session.save
		end	

		if (params.has_key?(:category_id))
			@tags = Tag.find(params[:category_id])
		    addTags(@tags)	    
		end
	    respond_to do |format|
	      if @org.save
	        format.html { redirect_to @org, notice: 'Kursen har skapats.' }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @course.errors, status: :unprocessable_entity }
	      end
	    end		
	end

	def new
	  	@org = Org.find(params[:id])
	    @course = Course.new
	    @locations = Location.all

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render :json => { :org => @org, :locations => @locations, :provinces => @provinces }}
	    end
	end
  	
  	def edit
    	@course = Course.find(params[:id])
    	@locations = Location.all
    	@provinces = Course.provinces
    	@tags = Tag.all

    	# Get the associated course sessions
    	@course_sessions = CourseSession.where("course_id = ?", params[:id])
    	# Get the tags that are currently selected
    	@active_tags = CourseTag.select("tag_id").where("course_id = ?", params[:id]).map { |t| t.tag_id }

  	end

  	def update
    	# Remove old sessions and create new 
		@course_sessions = CourseSession.where("course_id = ?", params[:id])
		@course_sessions.each do |cs|
			cs.destroy
		end
		
		sessions_start = params[:session_date_start]
		sessions_end = params[:session_date_end]
		
		if sessions_start
			sessions_start.each.with_index do |s, i|
				@session = CourseSession.new
				@session.course_id = params[:id]
						
				key = 'end'+ (i+1).to_s
				startdate = sessions_start[s.first]
				enddate = sessions_end[key] 
					
				dt = DateTime.strptime(startdate, '%Y-%d-%m %H:%M')
				dt_end = Time.strptime(enddate, '%H:%M')

				@session.start = dt
				@session.end = DateTime.new(dt.year, dt.month, dt.day, dt_end.hour, dt_end.min)	
				@session.save											
			end
		else
			(1..params[:course][:sessions].to_i).each do |s|
				@session = CourseSession.new
				@session.course_id = params[:id]
				@session.start = DateTime.now + 14
				@session.end = DateTime.now + 14
				@session.save
			end
		end
		

		# Remove old tags and create new
		@course_tags = CourseTag.where("course_id = ?", params[:id])
		
		@course_tags.each do |ct| 
			ct.destroy
		end

		if (params.has_key?(:category_id))
    		@tags = Tag.find(params[:category_id])
			addTags(@tags)   
    	end  	

    	respond_to do |format|
    	  if @course.update_attributes(params[:course])
        	format.html { redirect_to @course, notice: 'Kursen har uppdaterats.' }
        	format.json { head :no_content }
      	else
        	format.html { render action: "edit" }
        	format.json { render json: @course.errors, status: :unprocessable_entity }
      	end
    	end
  	end

  	def addTags(tags)
  		# Add new tags    
	    tags.each do |tag|
			@course_tag = CourseTag.new
			@course_tag.tag_id = tag.id
			@course_tag.course_id = @course.id
			@course_tag.save   			
	    end     		
  	end

	def show   
	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @course}
	    end
	end


	def destroy		
		@course = Course.find(params[:id])
		@org = @course.org
		@course.destroy
		
		respond_to do |format|
	      format.html { redirect_to orgs_url, notice: 'Kursen har tagits bort.' }
	      format.json { head :no_content }
	    end
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
