class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #helper_method :current_user
  before_filter :update_sanitized_params, if: :devise_controller?
  before_filter :configure_permitted_parameters, if: :devise_controller?	

    def update_sanitized_params
  	 #devise_parameter_sanitizer.for(:sign_up) << :email
     devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :phone_no, :image, :gender, :city, :year_of_birth, :profession, :name)}
    end	

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :phone_no, :image, :gender, :city, :year_of_birth, :profession, :name )}
      #devise_parameter_sanitizer.for(:sign_up) << :email
    end
end
