class RequestsController < ApplicationController
	
	before_action :correct_user, only: :destroy

	def index
		@requests = Request.all
		#@requests = Request.search(params[:search])
		#@users = User.paginate(:page => params[:page], :per_page => 5, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
	end

	def create
		@request = current_user.requests.build(request_params)
		if @request.save
			flash[:success] = "Post created!"
			redirect_to root_url
		else
			@feed_items = []
			render 'homes/index'	
		end		
	end

	def destroy
		@request.destroy
		redirect_to root_url
	end

	def show
		@users = User.all
		@requests = Request.all
	end

	private 

	def request_params
		params.require(:request).permit(:content, :destination, :source, :time, :date)
	end

	def correct_user
		@request = current_user.requests.find_by(id: params[:id])
		redirect_to root_url if @request.nil?
	end
end