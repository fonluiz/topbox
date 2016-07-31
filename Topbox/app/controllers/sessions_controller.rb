class SessionsController < ApplicationController
  before_action :save_login_state, only: [:new, :create]

  def new
  end

  def create
    @user = email_or_username(params[:session][:email_or_username])

    puts @user
    if @user && @user.authenticate(params[:session][:login_password])
      session[:user_id] = @user.id
      redirect_to '/home'
    else
      flash[:danger] = 'Usuário e/ou senha invalídos.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :action => 'new'
  end

  private
  def email_or_username(email_or_username="")
    if email_or_username != ""
      user ||= User.find_by_email(email_or_username)
      user ||= User.find_by_username(email_or_username)
    end

    return user
  end

end
