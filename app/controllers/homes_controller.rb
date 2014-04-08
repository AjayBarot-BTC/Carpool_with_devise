class HomesController < ApplicationController
	#before_filter :authenticate_user!

	def index
		@users = User.paginate(page: params[:page], :per_page => 5)
		if user_signed_in?
		@request = current_user.requests.build
		@feed_items = current_user.feed.paginate(page: params[:page], :per_page => 5)	
		end
	end
end