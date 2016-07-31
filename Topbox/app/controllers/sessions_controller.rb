class SessionsController < ApplicationController

  def new
  end

  def create
    @user_email = User.find_by_email(params[:session][:email])
    @username = User.find_by(params[:session][:username])
    if @user_email && @user_email.authenticate(params[:session][:password]) ||
        @username && @username.authenticate(params[:session][:password])
      puts @user_email.to_s
      session[:user_id] = @user_email.id unless @user_email.nil?
      session[:user_id] = @username.id unless @username.nil?
      redirect_to '/home'
    else
      flash.now[:error] = 'Invalid username/password combination.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
