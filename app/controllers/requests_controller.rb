class RequestsController < ApplicationController
	before_action :set_request, only: [:show, :edit, :update, :destroy]
	before_action :correct_user, only: :destroy

	def index
		#@requests = Request.search2(params[:search2])
		@requests = Request.paginate(:page => params[:page], :per_page => 5)
		@users = User.all
		@users = User.paginate(:page => params[:page], :per_page => 5)
		#@requests = Request.search(params[:keywords], :conditions => ['destination LIKE ?', "%#{params[:keywords]}%"])
		#@requests = Request.search(params[:search])
		#@users = User.paginate(:page => params[:page], :per_page => 5, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
	end

	def create
		#@request = current_user.requests.build(request_params)
		#if @request.save
		#	flash[:success] = "Post created!"
		#	redirect_to root_url
		#else
		#	@feed_items = []
		#	render 'homes/index'	
		#end		
	#end
	@request = current_user.requests.build(request_params)
	respond_to do |format|
		if @request.save
			format.html { redirect_to root_url, notice: 'Post created!' }
			#flash[:success] = "Post created!"
			format.js
			#format.json { render json: root_url, status: :created, location: root_url }
		else
			@feed_items = []
			format.html {}
			format.js
			#format.json { render json: @request.errors, status: :unprocessable_entity }
			render 'homes/index'	
		end	
		end
		end

	def destroy
		@request.destroy
			#respond_to do |format|
			flash[:success] = "Post deleted!"
			#format.html { redirect_to root_url, notice: "Post deleted" }
			#format.js { render nothing: true }
			redirect_to root_url
		#end
	end

	def show
		@users = User.all
		@requests = Request.all
	end

	private 

	def set_request
      @request = Request.find(params[:id])
    end

	def request_params
		params.require(:request).permit(:content, :destination, :source, :time, :date)
	end

	def correct_user
		@request = current_user.requests.find_by(id: params[:id])
		redirect_to root_url if @request.nil?
	end
end