class HomesController < ApplicationController
	#before_filter :authenticate_user!

	def index
		if signed_in?
		@request = current_user.requests.build 
		@feed_items = current_user.feed.paginate(page: params[:page])
		end	
	end
end