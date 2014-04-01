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
    #@users = User.all
    #@users = User.paginate(:page => params[:page], :per_page => 5
    if params[:search]
     # @users = User.paginate(:page => params[:page], :per_page => 5)
      @users = User.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
      #@requests = @users.find(:all, :conditions => ['source LIKE ?', "%#{params[:search2]}%"])   
      @users = User.paginate(:page => params[:page], :per_page => 5, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    else
      @users = User.find(:all)
      # @requests = @users.find(:all)  
      @users = User.paginate(:page => params[:page], :per_page => 5, :conditions => ['name LIKE ?', "%#{params[:search]}%"])      
    end

   # if params[:search2]

    #  @requests = @users.find(:all, :conditions => ['source LIKE ?', "%#{params[:search2]}%"])   
     # @requests = @users.paginate(:page => params[:page], :per_page => 5, :conditions => ['source LIKE ?', "%#{params[:search2]}%"])
    #else
    #  @requests = @users.find(:all)  
    #  @requests = @users.paginate(:page => params[:page], :per_page => 5, :conditions => ['source LIKE ?', "%#{params[:search2]}%"])
    #end

    #@users = User.paginate(:page => params[:page], :per_page => 5)
  end

	def show
		@user = User.find(params[:id])	
    @requests = @user.requests.paginate(page: params[:page], :per_page => 5)
	end

  	def new
    	@user = User.new
  	end

  	def edit
    	@user = User.find(params[:id])
  	end

  	def create
    	@user = User.new(user_params)
    	UserMailer.registration_confirmation(@user).deliver
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

    # Use callbacks to share common setup or constraints between actions.
  	private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :phone_no, :image, :gender, :city, :year_of_birth, :profession)
    end
end