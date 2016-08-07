class SessionsController < ApplicationController
  before_action :has_active_session?, only: [:new, :create]
  skip_before_filter :show_navbar, only: [:new, :create]

  def new
  end

  def create
    @user = email_or_username(params[:session][:email_or_username])

    if @user && @user.authenticate(params[:session][:login_password])
      log_in @user
      redirect_to_mytopbox
    else
      flash.now[:danger] = 'Usuário e/ou senha invalídos.'
      render :new
    end
  end

  def destroy
    log_out
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
