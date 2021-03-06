class SessionsController < ApplicationController
  def new
  end

  def create
     #user = User.find_by(email: params[:session][:email].downcase)
     
     user = User.where('email= ? OR username= ?',params[:session][:email].downcase, params[:session][:email]).first
     if user && user.authenticate(params[:session][:password])
        log_in user
        forget(user)
        redirect_to user
     else
     	flash[:danger] = 'Invalid email/password combination'
        render 'new'
     end
  end

  def destroy
     log_out if logged_in?
     redirect_to login_path
  end
end
