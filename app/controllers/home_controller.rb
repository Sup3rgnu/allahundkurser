class HomeController < ApplicationController
  def index
	@courses = Course.all
    respond_to do |format|
    	format.html # show.html.erb
		format.json { render json: @courses }
	end
  end
end
