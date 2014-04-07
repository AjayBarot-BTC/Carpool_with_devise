class UsersController < ApplicationController

	before_action :set_user, only: [:show, :edit, :update, :destroy]
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(:page => params[:page], :per_page => 5)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], :per_page => 5)
    render 'show_follow'
  end
  
  def index
    #@requests = Request.all
    #@users = User.joins(:requests)
    @messages = Message.all
    @users = User.search(params[:search])
    @users = User.paginate(:page => params[:page], :per_page => 5, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    #@users = User.paginate(:page => params[:page], :per_page => 5)
  end

	def show
    @message = Message.all
		@user = User.find(params[:id])
    @requests = @user.requests.paginate(page: params[:page], :per_page => 5)
    #@message = Message.find(params[:id])
	  #@messages = @user.paginate(page: params[:page])
  end

  	def new
    	@user = User.new
  	end

  	def edit
    	@user = User.find(params[:id])
  	end

  	def create
    	@user = User.new(user_params)
    	#UserMailer.registration_confirmation(@user).deliver
          if @user.save
          sign_in @user
          flash[:success] = "Welcome to the Fuelsaver!" 
          redirect_to @user
          else
          render 'new' 
          end
  	end    
  	def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
          flash[:success] = "Profile updated"
          redirect_to @user
        else
          render 'edit' 
        end
  	end
  	def destroy
    	User.find(params[:id]).destroy
    	flash[:success] = "User deleted."
    	redirect_to root_url
  	end
  	private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :phone_no, :image, :gender, :city, :year_of_birth, :profession)
    end
end