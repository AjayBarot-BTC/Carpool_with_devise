class UserMailer < ActionMailer::Base
  default from: "ajubarot@gmail.com"

  def registration_confirmation(email)
  	mail(:to => email, :subject => "Registered")
  end

end