class OrgsController < ApplicationController
  
  load_and_authorize_resource :except => [:getCourseCoords]
  
  # GET /orgs
  # GET /orgs.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orgs }
    end
  end

  # GET /orgs/1
  # GET /orgs/1.json
  def show

    @courses = @org.courses.all
    @locations = Location.all
    @tags = Tag.all
    @provinces = Course.provinces

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @org }
    end
  end

  # GET /orgs/new
  # GET /orgs/new.json
  def new    

    @org.url = 'http://'
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @org }
    end
  end

  # GET /orgs/1/edit
  def edit
    @org.user_id = current_user.id
  end

  # POST /orgs
  # POST /orgs.json
  def create

    @org.user_id = current_user.id
  
    respond_to do |format|
      if @org.save
        format.html { redirect_to @org, notice: 'Organisationen har skapats.' }
        format.json { render json: @org, status: :created, location: @org }
      else
        format.html { render action: "new" }
        format.json { render json: @org.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orgs/1
  # PUT /orgs/1.json
  def update

    respond_to do |format|
      if @org.update_attributes(params[:org])
        format.html { redirect_to @org, notice: 'Organisationen har uppdaterats.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @org.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orgs/1
  # DELETE /orgs/1.json
  def destroy

    @org.destroy

    respond_to do |format|
      format.html { redirect_to orgs_url, notice: 'Organisationen har tagits bort.' }
      format.json { head :no_content }
    end
  end

  def getCourseCoords
    @org = Org.find(params[:id])
    @courses = @org.courses.all 
    @mapMarkers = Array.new

    @courses.each do |course|
      @marker = Array.new
      @marker.push course
      @marker.push Location.find(course.location_id)     
      @mapMarkers.push @marker
    end 

      respond_to do |format|
        format.json { render json: @mapMarkers }
    end
  end  
end
