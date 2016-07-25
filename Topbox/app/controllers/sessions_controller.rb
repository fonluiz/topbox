class SessionsController < ApplicationController

  def new
  end

  def create
    @user_not_found = false
    @user_wrong_password = false

    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to '/'
    else
      @user_not_found = true unless @user
      redirect_to 'login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
