class TagsController < ApplicationController

load_and_authorize_resource :except => [:getCourseCoords]

def index
    @tags = Tag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags }
    end
  end

  def show
    @tag = Tag.find(params[:id])
    @courseTags = CourseTag.where("tag_id = ?", params[:id])
    @courses = Array.new
    @mapMarkers = Array.new

    @courseTags.each do |ct|
      @course = Course.find(ct.course_id)  
      @courses.push @course

      @marker = Array.new
      @marker.push @course
      @marker.push Location.find(@course.location_id)     
      @mapMarkers.push @marker
    end
      
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => {:tag => @tag, :courses => @courses }}
    end
  end

  def new
    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag }
    end
  end

  def create
    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Location was successfully created.' }
        format.json { render json: @tag, status: :created, tag: @tag }
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end   
  
  def getCourseCoords
    @tag = Tag.find(params[:id])
    @courseTags = CourseTag.where("tag_id = ?", params[:id])
    @courses = Array.new
    @mapMarkers = Array.new

    @courseTags.each do |ct|
      @course = Course.find(ct.course_id)  
      @marker = Array.new
      @marker.push @course
      @marker.push Location.find(@course.location_id)     
      @mapMarkers.push @marker
    end

      respond_to do |format|
        format.json { render json: @mapMarkers }
    end
  end  

end
