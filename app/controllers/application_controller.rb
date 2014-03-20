class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  protected
  	def configure_permitted_parameters
  	 devise_parameter_sanitizer.for(:sign_up) << :email
     devise_parameter_sanitizer.for(:sign_up) << :phone_no
     devise_parameter_sanitizer.for(:sign_up) << :image   
     devise_parameter_sanitizer.for(:sign_up) << :gender
     devise_parameter_sanitizer.for(:sign_up) << :city
     devise_parameter_sanitizer.for(:sign_up) << :year_of_birth
     devise_parameter_sanitizer.for(:sign_up) << :profession
     devise_parameter_sanitizer.for(:sign_up) << :name
    end	
end
