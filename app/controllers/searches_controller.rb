class SearchesController < ApplicationController
before_filter :authenticate_user!
before_action :set_search, only: [:show, :edit, :update, :destroy]
def show
    @searches = Search.find(params[:id])
end

def create
	#@user = User.new(user_params)
	@searches = Search.new(search_params)
    #redirect_to @searches
end

def index
	
	#@searches = Search.all
	#@searches = Search.search(params[:search])
	@users = User.all
	@searches = User.joins([:requests]).where("name LIKE ? OR destination LIKE ?","#{params[:search]}%", "#{params[:search]}%")
	#@searches = User.paginate(:page => params[:page], :per_page => 5, :conditions => ['name LIKE ? OR destination LIKE ?', "%#{params[:search]}%", "#{params[:search]}%"])
	@users = User.paginate(:page => params[:page], :per_page => 5)
	#redirect_to @searches
	#@requests = Request.all
end

def show
	@user = User.find(params[:id])	
    #@requests = @user.requests.paginate(page: params[:page], :per_page => 5)
end

def new
	@searches = Search.new
end

private

def set_search
	@searches = Search.find(params[:id])
end

def search_params
	params.require(:search).permit(:user_id, :request_id, :string)
end
end