class SessionsController < ApplicationController

  def new
  end

  def create
    @user_email = User.find_by_email(params[:session][:email])
    @username = User.find_by(params[:session][:username])
    if @user_email && @user_email.authenticate(params[:session][:password]) ||
        @username && @username.authenticate(params[:session][:password])
      session[:user_id] ||= @user_email.id
      session[:user_id] ||= @username.id
      redirect_to '/home'
    else
      flash.now[:error] = 'Invalid username/password combination.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
