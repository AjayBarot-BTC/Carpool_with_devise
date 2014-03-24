class AdminsController < ApplicationController
#before_filter :authenticate_admin!
def index
	@admins = Admin.all
	@users = User.all
end

def show
	#if admin_signed_in?
	#@user = User.find(params[:id])
	@users = User.all
	redirect_to root_url
end
end