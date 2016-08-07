class SessionsController < ApplicationController
  before_action :save_login_state, only: [:new, :create]
  skip_before_filter :show_navbar, only: [:new]

  def new
  end

  #Creates an user with an email or username
  #If the user exists log him in
  #If not shows an erro message.
  def create
    @user = email_or_username(params[:session][:email_or_username])

    if @user && @user.authenticate(params[:session][:login_password])
      log_in @user
      redirect_to '/folders/1'
    else
      flash.now[:danger] = 'Usuário e/ou senha invalídos.'
      render :new
    end
  end

  #Log out the user.
  def destroy
    log_out
    redirect_to :action => 'new'
  end

  #Receives an email or user name and searchs to see if there is an compatible user.
  private
  def email_or_username(email_or_username="")
    if email_or_username != ""
      user ||= User.find_by_email(email_or_username)
      user ||= User.find_by_username(email_or_username)
    end
    return user
  end


end
