class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page]).per(5)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def index
		@users = User.all.paginate(page: params[:page])
    #@users = User.all(params[:search]) 
  end

	def show
		@user = User.find(params[:id])	
    @requests = @user.requests.paginate(page: params[:page])
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
    	#UserMailer.registration_confirmation(@user).deliver
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

    # Use callbacks to share common setup or constraints between actions.
  	private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :phone_no, :image, :gender, :city, :year_of_birth, :profession)
    end
end